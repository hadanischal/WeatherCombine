//
//  WeeklyWeatherViewModelTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Cuckoo
import Nimble
import XCTest

@testable import WeatherCombine

final class WeeklyWeatherViewModelTests: XCTestCase {
    private var testViewModel: WeeklyWeatherViewModel!
    private var weatherFetchable: MockWeatherFetchable!

    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        guard let model = mockWeeklyWeatherResponse else { return }
        let mockPublisher: AnyPublisher<WeeklyWeatherResponse, NetworkError> = Just(model)
            .mapError { _ in NetworkError.unknown }
            .eraseToAnyPublisher()
        expect(model.list.count).to(equal(40))
        weatherFetchable = MockWeatherFetchable()
        stub(weatherFetchable) { stub in
            when(stub.weeklyWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }

        testViewModel = WeeklyWeatherViewModel(weatherFetcher: weatherFetchable)
    }

    override func tearDown() {
        subscriptions = []
    }

    func testSuccess() {
        // Given
        let expected: [WeeklyWeatherDTO] = weeklyWeatherDTO
        var results = [WeeklyWeatherDTO]()

        // When
        testViewModel.fetchWeather(forCity: "stub")

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).toEventually(equal(expected))
        expect(self.testViewModel.dataSource.count).to(equal(6))
        expect(expected.count).to(equal(6))

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )
    }

    func testEmptyResponse() {
        // Given
        let mockPublisher: AnyPublisher<WeeklyWeatherResponse, NetworkError> = .empty()
        stub(weatherFetchable) { stub in
            when(stub.weeklyWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }

        let expected: [WeeklyWeatherDTO] = []
        var results = [WeeklyWeatherDTO]()

        // When
        testViewModel.fetchWeather(forCity: "stub")

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).toEventually(equal(expected))
        expect(self.testViewModel.dataSource.count).to(equal(0))
        expect(expected.count).to(equal(0))

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )
    }

    func testFailure() {
        // Given
        let mockPublisher: AnyPublisher<WeeklyWeatherResponse, NetworkError> = .fail(NetworkError.unknown)
        stub(weatherFetchable) { stub in
            when(stub.weeklyWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }

        let expected: [WeeklyWeatherDTO] = []
        var results = [WeeklyWeatherDTO]()

        // When
        testViewModel.fetchWeather(forCity: "stub")

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).toEventually(equal(expected))
        expect(self.testViewModel.dataSource.count).to(equal(0))
        expect(expected.count).to(equal(0))

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )
    }

    // WeeklyWeatherResponse
    private var mockWeeklyWeatherResponse: WeeklyWeatherResponse? {
        return WeathersStubDataSource
            .stubWeeklyWeatherResponse()
    }

    private var weeklyWeatherDTO: [WeeklyWeatherDTO] {
        return mockWeeklyWeatherResponse?
            .list
            .map(WeeklyWeatherDTO.init)
            .removingDuplicates() ?? []
    }
}

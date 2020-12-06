//
//  WeatherListViewModelTests.swift
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

final class WeatherListViewModelTests: XCTestCase {
    private var testViewModel: WeatherListViewModel!
    private var weatherFetchable: MockWeatherListFetchable!

    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        let mockPublisher: AnyPublisher<[CurrentWeatherResponse], NetworkError> = .fail(.badURL)
        weatherFetchable = MockWeatherListFetchable()
        stub(weatherFetchable) { stub in
            when(stub.getCurrentWeather(forCities: any())).thenReturn(mockPublisher)
        }
        testViewModel = WeatherListViewModel(weatherFetcher: weatherFetchable)
    }

    override func tearDown() {
        subscriptions = []
    }

    func testSuccess() {
        // Given

        let model = mockCurrentWeatherResponse
        let mockPublisher: AnyPublisher<[CurrentWeatherResponse], NetworkError> =
            Just(model)
            .mapError { _ in NetworkError.unknown }
            .eraseToAnyPublisher()
        expect(model.count).to(equal(9))
        stub(weatherFetchable) { stub in
            when(stub.getCurrentWeather(forCities: any())).thenReturn(mockPublisher)
        }

        let expected: [WeatherListDTO] = weatherListDTO
        var results = [WeatherListDTO]()

        // When
        testViewModel.fetchWeather(forCities: [])

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).toEventually(equal(expected))
        expect(self.testViewModel.dataSource.count).to(equal(9))
        expect(expected.count).to(equal(9))

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )
    }

    func testEmptyResponse() {
        // Given
        let mockPublisher: AnyPublisher<[CurrentWeatherResponse], NetworkError> = .empty()
        stub(weatherFetchable) { stub in
            when(stub.getCurrentWeather(forCities: any())).thenReturn(mockPublisher)
        }

        let expected: [WeatherListDTO] = []
        var results = [WeatherListDTO]()

        // When
        testViewModel.fetchWeather(forCities: [])

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
        let mockPublisher: AnyPublisher<[CurrentWeatherResponse], NetworkError> = .fail(.unknown)
        stub(weatherFetchable) { stub in
            when(stub.getCurrentWeather(forCities: any())).thenReturn(mockPublisher)
        }

        let expected: [WeatherListDTO] = []
        var results = [WeatherListDTO]()

        // When
        testViewModel.fetchWeather(forCities: [])

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

    // CurrentWeatherResponse
    private var mockCurrentWeatherResponse: [CurrentWeatherResponse] {
        return WeathersStubDataSource
            .stubCityWeatherListResponse()?
            .weatherList ?? []
    }

    private var weatherListDTO: [WeatherListDTO] {
        return mockCurrentWeatherResponse
            .map(WeatherListDTO.init)
            .removingDuplicates()
    }
}

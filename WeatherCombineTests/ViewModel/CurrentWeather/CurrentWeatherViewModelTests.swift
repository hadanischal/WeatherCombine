//
//  CurrentWeatherViewModelTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
import Cuckoo
import XCTest
import Combine

@testable import WeatherCombine

final class CurrentWeatherViewModelTests: XCTestCase {
    private var testViewModel: CurrentWeatherViewModel!
    private var weatherFetchable: MockWeatherFetchable!

    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  = .fail(.badURL)
        weatherFetchable = MockWeatherFetchable()
        stub(weatherFetchable) { stub in
            when(stub.currentWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }
        testViewModel = CurrentWeatherViewModel(city: "stub",
                                                weatherFetcher: weatherFetchable)
    }

    override func tearDown() {
        subscriptions = []
    }

    func testSuccess() {
        // Given

        guard let model = mockCurrentWeatherResponse else {
            fail("stub info is null")
            return
        }

        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  =
            Just(model)
                .mapError({ _ in  NetworkError.unknown })
                .eraseToAnyPublisher()
        stub(weatherFetchable) { stub in
            when(stub.currentWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }


        guard let expected = weatherListDTO else { return }
        var results: CurrentWeatherDTO!

        // When
        testViewModel.refresh()

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).toEventually(equal(expected))
        expect(self.testViewModel.dataSource).toNot(beNil())

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )

    }

    func testEmptyResponse() {
        // Given
        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  = .empty()
         stub(weatherFetchable) { stub in
                when(stub.currentWeatherForecast(forCity: any())).thenReturn(mockPublisher)
            }

        let expected: CurrentWeatherDTO? = nil
        var results: CurrentWeatherDTO?

        // When
        testViewModel.refresh()

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).to(beNil())

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )

    }

    func testFailure() {
        // Given
        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  = .fail(.unknown)
        stub(weatherFetchable) { stub in
            when(stub.currentWeatherForecast(forCity: any())).thenReturn(mockPublisher)
        }

        let expected: CurrentWeatherDTO? = nil
        var results: CurrentWeatherDTO?


        // When
        testViewModel.refresh()

        let publisher = testViewModel.$dataSource
        // 4
        publisher
            .sink(receiveValue: {
                results = $0
            })
            .store(in: &subscriptions)

        // Then
        expect(self.testViewModel.dataSource).to(beNil())

        XCTAssert(
            results == expected,
            "Results expected to be \(expected) but were \(results)"
        )

    }
    // CurrentWeatherResponse
    private var mockCurrentWeatherResponse: CurrentWeatherResponse? {
        return WeathersStubDataSource
            .stubCurrentWeatherResponse()
    }

    private var weatherListDTO: CurrentWeatherDTO? {
        return mockCurrentWeatherResponse
            .map(CurrentWeatherDTO.init)
    }

}

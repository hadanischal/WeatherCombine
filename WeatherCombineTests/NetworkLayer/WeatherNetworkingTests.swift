//
//  WeatherNetworkingTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 27/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
import Cuckoo
import XCTest
import Combine
@testable import WeatherCombine

final class WeatherNetworkingTests: XCTestCase {
    private var testViewModel: WeatherNetworking!
    private var weatherFetchable: MockNetworkServiceHandling!

    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  = .fail(.badURL)
        weatherFetchable = MockNetworkServiceHandling()
        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }
        testViewModel = WeatherNetworking(networkService: weatherFetchable)
    }

    override func tearDown() {
        subscriptions = []
    }

    func testWeeklyWeatherForecastSuccess() {
        // Given
        let expectation = self.expectation(description: #function)
        let expected = mockWeeklyWeatherResponse

        let mockPublisher: AnyPublisher<WeeklyWeatherResponse, NetworkError>  =
            Just(expected)
                .mapError({ _ in  NetworkError.unknown })
                .eraseToAnyPublisher()

        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }
        var results: WeeklyWeatherResponse!

        // When

        testViewModel.weeklyWeatherForecast(forCity: "stub")
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)

        if let response = results {
            XCTAssert(
                response == expected,
                "Results expected to be \(expected) but were \(response)"
            )

        } else {
            XCTFail("result is null")
        }

    }

    func testWeeklyWeatherForecastFailure() {
        // Given
        let expectation = self.expectation(description: #function)
        let mockPublisher: AnyPublisher<WeeklyWeatherResponse, NetworkError>  = .fail(.unknown)
        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }

        var results: WeeklyWeatherResponse!

        // When
        testViewModel.weeklyWeatherForecast(forCity: "stub")
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNil(results)
    }

    func testCurrentWeatherForecastSuccess() {
        // Given
        let expectation = self.expectation(description: #function)
        let expected = mockCurrentWeatherResponse

        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  =
            Just(expected)
                .mapError({ _ in  NetworkError.unknown })
                .eraseToAnyPublisher()

        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }
        var results: CurrentWeatherResponse!

        // When

        testViewModel.currentWeatherForecast(forCity: "stub")
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)

        if let response = results {
            XCTAssert(
                response == expected,
                "Results expected to be \(expected) but were \(response)"
            )

        } else {
            XCTFail("result is null")
        }

    }

    func testCurrentWeatherForecastFailure() {
        // Given
        let expectation = self.expectation(description: #function)
        let mockPublisher: AnyPublisher<CurrentWeatherResponse, NetworkError>  = .fail(.unknown)
        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }

        var results: CurrentWeatherResponse!

        // When
        testViewModel.currentWeatherForecast(forCity: "stub")
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNil(results)
    }


    func testGetCurrentWeatherSuccess() {
        // Given
        let expectation = self.expectation(description: #function)
        let expected = mockCityWeatherListResponse

        let mockPublisher: AnyPublisher<CityWeatherListResponse, NetworkError>  =
            Just(expected)
                .mapError({ _ in  NetworkError.unknown })
                .eraseToAnyPublisher()

        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }
        var results: [CurrentWeatherResponse]!

        // When

        testViewModel.getCurrentWeather(forCities: [])
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)

        if let response = results {
            XCTAssert(
                response == expected.weatherList,
                "Results expected to be \(expected) but were \(response)"
            )

        } else {
            XCTFail("result is null")
        }

    }

    func testGetCurrentWeatherFailure() {
        // Given
        let expectation = self.expectation(description: #function)
        let mockPublisher: AnyPublisher<CityWeatherListResponse, NetworkError>  = .fail(.unknown)
        stub(weatherFetchable) { stub in
            when(stub.load(any())).thenReturn(mockPublisher)
        }
        var results: [CurrentWeatherResponse]!

        // When
        testViewModel.getCurrentWeather(forCities: [])
            .sink(
                receiveCompletion: { _ in expectation.fulfill() },
                receiveValue: { results = $0 }
        )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertNil(results)

    }

    // WeeklyWeatherResponse
    private var mockWeeklyWeatherResponse: WeeklyWeatherResponse {
        guard let response = WeathersStubDataSource
            .stubWeeklyWeatherResponse() else {
                preconditionFailure("WeeklyWeatherResponse response cannot be null")
        }
        return response
    }

    // CurrentWeatherResponse
    private var mockCurrentWeatherResponse: CurrentWeatherResponse {
        guard let response = WeathersStubDataSource
            .stubCurrentWeatherResponse() else {
                preconditionFailure("CurrentWeatherResponse response cannot be null")
        }
        return response
    }

    // List of CurrentWeatherResponse
    private var mockCityWeatherListResponse: CityWeatherListResponse {
        guard let response = WeathersStubDataSource
            .stubCityWeatherListResponse()
            else {
                preconditionFailure("CityWeatherListResponse response cannot be null")
        }
        return response
    }
}

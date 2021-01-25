//
//  NetworkServiceTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 6/12/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Cuckoo
import Nimble
import OHHTTPStubs
@testable import WeatherCombine
import XCTest

final class NetworkServiceTests: XCTestCase {
    private var testViewModel: NetworkService!
    var subscriptions = Set<AnyCancellable>()

    override func setUp() {
        testViewModel = NetworkService()
    }

    override func tearDown() {
        subscriptions = []
    }

    func testWeeklyWeatherForecastSuccess() {
        // Given
        let expectation = self.expectation(description: #function)
        guard let url = URL.forecastUrl else { return }
        let resource: Resource<WeeklyWeatherResponse> = { Resource(url: url, parameter: OpenWeatherAPI.components) }()

        stub(condition: isHost(OpenWeatherAPI.ApiConfig.host)) { _ in
            let stubPath = OHPathForFile("weeklyWeather.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }

        let expected = mockWeeklyWeatherResponse
        var results: WeeklyWeatherResponse!

        // When
        testViewModel.load(resource)
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
                "Results expected to be \n\n\(expected) but were \n\n\(response)\n\n"
            )

        } else {
            XCTFail("result is null")
        }
    }

    func testWeeklyWeatherForecastError() {
        // Given
        let expectation = self.expectation(description: #function)
        guard let url = URL.forecastUrl else { return }
        let resource: Resource<WeeklyWeatherResponse> = { Resource(url: url, parameter: OpenWeatherAPI.components) }()

        stub(condition: isHost(OpenWeatherAPI.ApiConfig.host)) { _ in
            let stubPath = OHPathForFile("error401.json", type(of: self))
            return fixture(filePath: stubPath!, status: 401, headers: ["Content-Type": "application/json"])
        }

        var results: WeeklyWeatherResponse!

        // When
        testViewModel.load(resource)
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case let .failure(error):
                        expect(error.localizedDescription).toNot(beNil())
                        expectation.fulfill()

                    case .finished:
                        break
                    }
            },
                receiveValue: { results = $0 }
            )
            .store(in: &subscriptions)

        // Then
        waitForExpectations(timeout: 2, handler: nil)
        expect(results).to(beNil())
    }

    // WeeklyWeatherResponse
    private var mockWeeklyWeatherResponse: WeeklyWeatherResponse {
        guard let response = WeathersStubDataSource
            .stubWeeklyWeatherResponse() else {
                preconditionFailure("WeeklyWeatherResponse response cannot be null")
        }
        return response
    }
}

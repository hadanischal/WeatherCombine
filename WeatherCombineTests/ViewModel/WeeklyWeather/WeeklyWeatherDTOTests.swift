//
//  WeeklyWeatherDTOTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
import XCTest

@testable import WeatherCombine

final class WeeklyWeatherDTOTests: XCTestCase {
    private var testViewModel: WeeklyWeatherDTO!

    override func setUp() {
        guard let model = stubSetup() else {
            fail("WeatherResult is nil")
            return
        }
        testViewModel = WeeklyWeatherDTO(withWeatherResult: model)
    }

    override func tearDown() {}

    func testExample() {
        expect(self.testViewModel.id).to(equal("07-18.6-Clouds"))
        expect(self.testViewModel.day).to(equal("07"))
        expect(self.testViewModel.month).to(equal("October"))
        expect(self.testViewModel.temperature).to(equal("18.6"))
        expect(self.testViewModel.title).to(equal("Clouds"))
        expect(self.testViewModel.fullDescription).to(equal("overcast clouds"))
    }

    // CurrentWeatherResponse
    private func stubSetup() -> WeatherResult? {
        let stub = WeathersStubDataSource.stubWeeklyWeatherResponse()
        return stub?.list.first
    }
}

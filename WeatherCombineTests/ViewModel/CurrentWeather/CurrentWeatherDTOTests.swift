//
//  CurrentWeatherDTOTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
import XCTest

@testable import WeatherCombine

final class CurrentWeatherDTOTests: XCTestCase {
    private var testViewModel: CurrentWeatherDTO!

    override func setUp() {
        guard let model = stubSetup() else {
            fail("WeatherResult is nik")
            return
        }
        testViewModel = CurrentWeatherDTO(item: model)
    }

    override func tearDown() {}

    func testExample() {
        expect(self.testViewModel.temperature).to(equal("23.7"))
        expect(self.testViewModel.maxTemperature).to(equal("25.0"))
        expect(self.testViewModel.minTemperature).to(equal("22.8"))
        expect(self.testViewModel.humidity).to(equal("0.0"))
        expect(self.testViewModel.coordinate.latitude.description).to(equal("-27.47"))
        expect(self.testViewModel.coordinate.longitude.description).to(equal("153.03"))
    }

    // CurrentWeatherResponse
    private func stubSetup() -> CurrentWeatherResponse? {
        WeathersStubDataSource.stubCurrentWeatherResponse()
    }
}

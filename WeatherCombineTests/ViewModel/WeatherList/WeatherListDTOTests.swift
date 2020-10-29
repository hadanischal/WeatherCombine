//
//  WeatherListDTOTests.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Nimble
import XCTest

@testable import WeatherCombine

final class WeatherListDTOTests: XCTestCase {
    private var testViewModel: WeatherListDTO!

    override func setUp() {
        guard let model = stubSetup() else {
            fail("WeatherResult is nik")
            return
        }
        testViewModel = WeatherListDTO(currentWeatherResponse: model)
    }

    override func tearDown() {}

    func testExample() {
        expect(self.testViewModel.id).to(equal("2174003"))
        expect(self.testViewModel.temperature).to(equal("23.7"))
        expect(self.testViewModel.maxTemperature).to(equal("25.0"))
        expect(self.testViewModel.minTemperature).to(equal("22.8"))
        expect(self.testViewModel.humidity).to(equal("0.0"))
        expect(self.testViewModel.name).to(equal("Brisbane"))
    }

    // CurrentWeatherResponse
    private func stubSetup() -> CurrentWeatherResponse? {
        WeathersStubDataSource.stubCurrentWeatherResponse()
    }
}

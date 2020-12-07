//
//  WeathersStub.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

@testable import WeatherCombine
import XCTest

enum WeathersStub: String {
    case weatherDetail
    case weatherList
    case weeklyWeather
}

extension WeathersStub {
    var path: URL? {
        Bundle(for: WeatherCombineTests.self).url(forResource: rawValue, withExtension: "json")
    }

    var data: Data? {
        guard let url = path else {
            XCTFail("Missing file: \(rawValue).json")
            return nil
        }

        do {
            let json = try Data(contentsOf: url)
            return json
        } catch {
            XCTFail("unable to read json")
            return nil
        }
    }
}

struct WeathersStubDataSource {
    static func stubWeeklyWeatherResponse() -> WeeklyWeatherResponse? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        if let data = WeathersStub.weeklyWeather.data,
            let response = try? decoder.decode(WeeklyWeatherResponse.self, from: data) {
            return response
        } else {
            XCTFail("Unable to parse WeeklyWeatherResponse results")
            return nil
        }
    }

    static func stubCurrentWeatherResponse() -> CurrentWeatherResponse? {
        if let data = WeathersStub.weatherDetail.data,
            let response = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: data) {
            return response
        } else {
            XCTFail("Unable to parse CurrentWeatherResponse results")
            return nil
        }
    }

    static func stubCityWeatherListResponse() -> CityWeatherListResponse? {
        if let data = WeathersStub.weatherList.data,
            let response = try? JSONDecoder().decode(CityWeatherListResponse.self, from: data) {
            return response
        } else {
            XCTFail("Unable to parse CityWeatherListResponse results")
            return nil
        }
    }
}

//
//  WeatherNetworkingPreviewHelpers.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 10/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation
import OHHTTPStubs

// Refrence Example of OHHTTPStubs
// https://github.com/AliSoftware/OHHTTPStubs/wiki/Usage-Examples

final class WeatherNetworkingPreviewHelpers: WeatherNetworkHandler {
    private let networkService: WeatherNetworkHandler

    init(networkService: WeatherNetworkHandler = WeatherNetworking()) {
        self.networkService = networkService
    }

    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyWeatherResponse, NetworkError> {
        stub(condition: isHost(OpenWeatherAPI.ApiConfig.host)) { _ in
            let stubPath = OHPathForFile("weeklyWeather.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
        return networkService.weeklyWeatherForecast(forCity: "stub")
    }

    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherResponse, NetworkError> {
        stub(condition: isHost(OpenWeatherAPI.ApiConfig.host)) { _ in
            let stubPath = OHPathForFile("weatherDetail.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
        return networkService.currentWeatherForecast(forCity: "stub")
    }

    func getCurrentWeather(forCities cityIds: [String]) -> AnyPublisher<[CurrentWeatherResponse], NetworkError> {
        stub(condition: isHost(OpenWeatherAPI.ApiConfig.host)) { _ in
            let stubPath = OHPathForFile("weatherList.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type": "application/json"])
        }
        return networkService.getCurrentWeather(forCities: ["stub"])
    }
}

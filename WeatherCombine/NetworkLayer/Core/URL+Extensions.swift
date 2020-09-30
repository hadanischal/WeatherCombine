//
//  URL+Extensions.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

extension URL {
    static var forecastUrl: URL? { URL(string: OpenWeatherAPI.openWeatherURL + OpenWeatherAPI.pathForecast) }
    static var weatherUrl: URL? { URL(string: OpenWeatherAPI.openWeatherURL + OpenWeatherAPI.pathWeather) }
}

struct OpenWeatherAPI {
    static let openWeatherURL = baseURL + path
    static let baseURL = "https://api.openweathermap.org/"
    static let path = "data/2.5/"
    static let pathForecast = "forecast"
    static let pathWeather = "weather"
    static let key = "7d504cbcfe2698bf9c66ab2fd1602452"

    static let components: [String: String] = {
        [
            "mode": "json",
            "units": "metric",
            "APPID": key
        ]
    }()
}

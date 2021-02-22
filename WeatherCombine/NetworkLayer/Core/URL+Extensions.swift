//
//  URL+Extensions.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

private let apiConfig = OpenWeatherAPI.ApiConfig.self
extension URL {
    static var forecastUrl: URL? { URL(string: apiConfig.serverPath + apiConfig.pathForecast) }
    static var weatherUrl: URL? { URL(string: apiConfig.serverPath + apiConfig.pathWeather) }
    static var groupUrl: URL? { URL(string: apiConfig.serverPath + apiConfig.pathGroup) }
}

struct OpenWeatherAPI {
    enum ApiConfig {
        static let host = "api.openweathermap.org"
        static let serverPath: String = baseURL + path
        static let baseURL = "https://api.openweathermap.org/"
        static let path = "data/2.5/"
        static let weatherUnit: String = "metric"

        static let pathForecast = "forecast"
        static let pathWeather = "weather"
        static let pathGroup = "group"
    }

    /// https://api.openweathermap.org/data/2.5/forecast?q=Sydney&units=metric&APPID=7d504cbcfe2698bf9c66ab2fd1602452&mode=json

    /// API Documentation: http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&units=metric
    /// The list Ids of capital cities in Australia as per provided by Open Weather Map API
    static let CityIDs: [String] = [
        "2147714", // Sydney
        "7839805", // Melbourne
        "2174003", // Brisbane
        "7839581", // Gold Coast
        "2078025", // Adelaide
        "2063523", // Perth
        "2172517", // Canberra
        "2163355", // Hobart
        "7839402" // Darwin
    ]
}

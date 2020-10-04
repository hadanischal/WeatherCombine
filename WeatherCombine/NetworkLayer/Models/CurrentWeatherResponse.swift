//
//  CurrentWeatherResponse.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - CurrentWeatherResponse

struct CurrentWeatherResponse: Codable {
    let dt, id: Int
    let main: Main
    let coord: Coord
    let weather: [Weather]
    let sys: Sys1
    let wind: Wind
    let clouds: Clouds
    let visibility: Int
    let name: String

    let base: String?
    let timezone: Int?
    let cod: Int?
}

// MARK: - Main

struct Main: Codable {
    let temperature, feelsLike, maxTemperature, minTemperature: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case pressure, humidity
    }
}

// MARK: - Sys

struct Sys1: Codable {
    let type, id: Int?
    let country: String
    let timezone, sunrise, sunset: Int?
}

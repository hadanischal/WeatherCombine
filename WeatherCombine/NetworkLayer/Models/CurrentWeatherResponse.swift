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
    let dt: Int
    let main: Main
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let coord: Coord
    let base: String
    let sys: Sys1
    let timezone, id: Int
    let name: String
    let cod: Int
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
    let type, id: Int
    let country: String
    let sunrise, sunset: Int
}

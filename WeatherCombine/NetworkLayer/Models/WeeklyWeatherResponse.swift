//
//  WeeklyWeatherResponse.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - WeeklyWeatherResponse

struct WeeklyWeatherResponse: Codable {
    let cod: String
    let message, cnt: Int
    let list: [WeatherResult]
    let city: City
}

// MARK: - City

struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

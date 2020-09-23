//
//  CommonModel.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - Coord

struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Clouds

struct Clouds: Codable {
    let all: Int
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

// MARK: - Weather

struct Weather: Codable {
    let id: Int
    let main: MainEnum
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// enum Description: String, Codable {
//    case clearSky = "clear sky"
//    case fewClouds = "few clouds"
//    case lightRain = "light rain"
//    case moderateRain = "moderate rain"
//    case scatteredClouds = "scattered clouds"
// }

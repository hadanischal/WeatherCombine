//
//  CommonModel.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - Coord

struct Coord: Codable, Equatable {
    let lat, lon: Double
}

// MARK: - Clouds

struct Clouds: Codable, Equatable {
    let all: Int
}

// MARK: - Wind

struct Wind: Codable, Equatable {
    let speed: Double
    let deg: Int
}

// MARK: - Weather

struct Weather: Codable, Equatable {
    let id: Int
    let main: String
    let weatherDescription: String
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

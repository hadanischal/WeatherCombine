//
//  CityWeatherListResponse.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 4/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - CityWeatherListResponse
struct CityWeatherListResponse: Codable {
    var count: Int
    var weatherList: [CurrentWeatherResponse]

    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case weatherList = "list"
    }
}

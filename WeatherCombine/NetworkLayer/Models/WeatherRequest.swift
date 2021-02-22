//
//  WeatherRequest.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 25/1/21.
//  Copyright © 2021 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - WeatherRequest

struct WeatherRequest: EncoderProtocol {
    let mode: String = "json"
    let units: String
    let appId: String
    let id: String?
    let city: String?

    init(
        units: String = OpenWeatherAPI.ApiConfig.weatherUnit,
        appId: String = Configuration().apiKey,
        id: String? = nil,
        city: String? = nil
    ) {
        self.units = units
        self.appId = appId
        self.id = id
        self.city = city
    }

    enum CodingKeys: String, CodingKey {
        case mode
        case units
        case appId = "APPID"
        case id
        case city = "q"
    }
}

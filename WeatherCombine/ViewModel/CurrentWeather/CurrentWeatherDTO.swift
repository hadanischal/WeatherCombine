//
//  CurrentWeatherDTO.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation
import MapKit

struct CurrentWeatherDTO {
    let temperature: String
    let maxTemperature: String
    let minTemperature: String
    let humidity: String
    let coordinate: CLLocationCoordinate2D

    init(item: CurrentWeatherResponse) {
        self.temperature = item.main.temperature.roundSinglePlace
        self.maxTemperature = item.main.maxTemperature.roundSinglePlace
        self.minTemperature = item.main.minTemperature.roundSinglePlace
        self.humidity = item.main.humidity.roundSinglePlace
        self.coordinate = CLLocationCoordinate2D(latitude: item.coord.lat, longitude: item.coord.lon)
    }
}

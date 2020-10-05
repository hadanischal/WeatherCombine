//
//  WeatherListDTO.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 4/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - WeatherListDTO

struct WeatherListDTO: Identifiable {
    let id: String
    let temperature: String
    let maxTemperature: String
    let minTemperature: String
    let humidity: String
    let name: String
//    let coordinate: CLLocationCoordinate2D

    init(item: CurrentWeatherResponse) {
        self.id = "\(item.id)"
        self.temperature = item.main.temperature.roundSinglePlace
        self.maxTemperature = item.main.maxTemperature.roundSinglePlace
        self.minTemperature = item.main.minTemperature.roundSinglePlace
        self.humidity = item.main.humidity.roundSinglePlace
        self.name = item.name
//        self.coordinate = CLLocationCoordinate2D(latitude: item.coord.lat, longitude: item.coord.lon)
    }
}

// Used to hash on just the day in order to produce a single view model for each
// day when there are multiple items per each day.
extension WeatherListDTO: Hashable {
    static func == (lhs: WeatherListDTO, rhs: WeatherListDTO) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

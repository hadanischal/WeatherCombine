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
    private let currentWeatherResponse: CurrentWeatherResponse
    var id: String { "\(currentWeatherResponse.id)" }
    var temperature: String { currentWeatherResponse.main.temperature.roundSinglePlace }
    var maxTemperature: String { currentWeatherResponse.main.maxTemperature.roundSinglePlace }
    var minTemperature: String { currentWeatherResponse.main.minTemperature.roundSinglePlace }
    var humidity: String { currentWeatherResponse.main.humidity.roundSinglePlace }
    var name: String { currentWeatherResponse.name }
//    let coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: currentWeatherResponse.coord.lat, longitude: currentWeatherResponse.coord.lon) }

    init(currentWeatherResponse: CurrentWeatherResponse) {
        self.currentWeatherResponse = currentWeatherResponse
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

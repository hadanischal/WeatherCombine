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
    private let item: CurrentWeatherResponse

    var temperature: String { item.main.temperature.roundSinglePlace }
    var maxTemperature: String { item.main.maxTemperature.roundSinglePlace }
    var minTemperature: String { item.main.minTemperature.roundSinglePlace }
    var humidity: String { item.main.humidity.roundSinglePlace }
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: item.coord.lat, longitude: item.coord.lon) }

    init(item: CurrentWeatherResponse) {
        self.item = item
    }
}

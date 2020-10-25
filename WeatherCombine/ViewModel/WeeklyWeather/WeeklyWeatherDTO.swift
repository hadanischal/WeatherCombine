//
//  WeeklyWeatherDTO.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

// MARK: - WeeklyWeatherDTO

struct WeeklyWeatherDTO: Identifiable {
    private let weatherResult: WeatherResult

    var id: String { "\(day)-\(temperature)-\(title)" }
    var day: String { dayFormatter.string(from: weatherResult.date) }
    var month: String { monthFormatter.string(from: weatherResult.date) }
    var temperature: String { weatherResult.main.temp.roundSinglePlace }

    var title: String { weatherResult.weather.first?.main ?? "" }
    var fullDescription: String { weatherResult.weather.first?.weatherDescription ?? "" }

    init(withWeatherResult weatherResult: WeatherResult) {
        self.weatherResult = weatherResult
    }
}

// Used to hash on just the day in order to produce a single view model for each
// day when there are multiple items per each day.
extension WeeklyWeatherDTO: Hashable {
    static func == (lhs: WeeklyWeatherDTO, rhs: WeeklyWeatherDTO) -> Bool {
        return lhs.day == rhs.day
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}

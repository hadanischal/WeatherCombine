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
    var id: String { day + temperature + title }
    let day: String
    let month: String
    let temperature: String

    let title: String
    let fullDescription: String

    init(withWeatherResult item: WeatherResult) {
        self.day = dayFormatter.string(from: item.date)
        self.month = monthFormatter.string(from: item.date)
        self.temperature = item.main.temp.roundSinglePlace
        self.title = item.weather.first?.main ?? ""
        self.fullDescription = item.weather.first?.weatherDescription ?? ""
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

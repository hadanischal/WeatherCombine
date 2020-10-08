//
//  WeeklyWeatherViewModel+Extension.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

extension WeeklyWeatherViewModel {
    var currentWeatherView: some View {
        return WeeklyWeatherBuilder.makeCurrentWeatherView(withCity: city)
    }
}

extension WeatherListViewModel {
    func currentWeatherView(_ city: String) -> some View {
        return WeeklyWeatherBuilder.makeCurrentWeatherView(withCity: city)
    }

    func weeklyWeatherView() -> some View {
        return WeeklyWeatherBuilder.weeklyWeatherView
    }
}

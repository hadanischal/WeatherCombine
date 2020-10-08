//
//  WeeklyWeatherBuilder.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

enum WeeklyWeatherBuilder {
    static func makeCurrentWeatherView(withCity city: String) -> some View {
        let viewModel = CurrentWeatherViewModel(city: city)
        return CurrentWeatherView(viewModel: viewModel)
    }

    static var weeklyWeatherView: some View {
        return WeeklyWeatherView()
    }
}

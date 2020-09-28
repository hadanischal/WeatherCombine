//
//  CurrentWeatherCell.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct CurrentWeatherCell: View {
    private let viewModel: CurrentWeatherDTO

    init(viewModel: CurrentWeatherDTO) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading) {
            MapView(coordinate: viewModel.coordinate)
                .cornerRadius(25)
                .frame(height: 300)
                .disabled(true)

            VStack(alignment: .leading) {
                HStack {
                    Text("☀️ Temperature:")
                    Text("\(viewModel.temperature)°")
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("📈 Max temperature:")
                    Text("\(viewModel.maxTemperature)°")
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("📉 Min temperature:")
                    Text("\(viewModel.minTemperature)°")
                        .foregroundColor(.gray)
                }

                HStack {
                    Text("💧 Humidity:")
                    Text(viewModel.humidity)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

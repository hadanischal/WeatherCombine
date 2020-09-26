//
//  DailyWeatherCell.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct DailyWeatherCell: View {
    private let viewModel: WeeklyWeatherDTO

    init(viewModel: WeeklyWeatherDTO) {
        self.viewModel = viewModel
    }

    var body: some View {
        HStack {
            VStack {
                Text("\(viewModel.day)")
                Text("\(viewModel.month)")
            }

            VStack(alignment: .leading) {
                Text("\(viewModel.title)")
                    .font(.body)
                Text("\(viewModel.fullDescription)")
                    .font(.footnote)
            }
            .padding(.leading, 8)

            Spacer()

            Text("\(viewModel.temperature)°")
                .font(.title)
        }
    }
}

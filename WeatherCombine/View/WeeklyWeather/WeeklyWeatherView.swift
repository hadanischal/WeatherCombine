//
//  WeeklyWeatherView.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct WeeklyWeatherView: View {
    @ObservedObject var viewModel: WeeklyWeatherViewModel

    init(viewModel: WeeklyWeatherViewModel = WeeklyWeatherViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                searchField
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    cityHourlyWeatherSection
                    forecastSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
        }
    }

    private var searchField: some View {
        HStack(alignment: .center) {
            TextField("e.g. Cupertino", text: $viewModel.city)
        }
    }

    private var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource, content: DailyWeatherCell.init(viewModel:))
        }
    }

    private var cityHourlyWeatherSection: some View {
        Section {
            NavigationLink(destination: viewModel.currentWeatherView) {
                VStack(alignment: .leading) {
                    Text(viewModel.city)
                    Text("Weather today")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
    }

    private var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}

/*
private var forecastSection: some View {
    Section {
        ForEach(viewModel.dataSource) { color in
            NavigationLink(destination: self.viewModel.currentWeatherView) {

                return DailyWeatherCell(viewModel: color)
            }
        }
    }
}
 */

//
//  WeatherListView.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 4/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct WeatherListView: View {
    @ObservedObject var viewModel: WeatherListViewModel

    init(viewModel: WeatherListViewModel = WeatherListViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            List {
                if viewModel.dataSource.isEmpty {
                    searchField
                    emptySection
                } else {
                    searchField
                    forecastSection
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Weather ⛅️")
        }
    }

    private var searchField: some View {
        NavigationLink(destination: self.viewModel.weeklyWeatherView()) {
            HStack(alignment: .center) {
                Text("e.g. Search")
            }                      }

    }

    private var forecastSection: some View {
        Section {
            ForEach(viewModel.dataSource) { data in
                NavigationLink(destination: self.viewModel.currentWeatherView(data.name)) {
                    WeatherListCell(viewModel: data)
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

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView()
    }
}

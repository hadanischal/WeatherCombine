//
//  CurrentWeatherView.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import SwiftUI

struct CurrentWeatherView: View {
    @ObservedObject var viewModel: CurrentWeatherViewModel

    init(viewModel: CurrentWeatherViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List(content: content)
            .onAppear(perform: viewModel.refresh)
            .navigationBarTitle(viewModel.city)
            .listStyle(GroupedListStyle())
    }

    private func content() -> some View {
        if let viewModel = viewModel.dataSource {
            return AnyView(details(for: viewModel))
        } else {
            return AnyView(loading)
        }
    }

    private func details(for viewModel: CurrentWeatherDTO) -> some View {
        CurrentWeatherCell(viewModel: viewModel)
    }

    private var loading: some View {
        Text("Loading \(viewModel.city)'s weather...")
            .foregroundColor(.gray)
    }
}

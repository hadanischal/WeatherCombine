//
//  CurrentWeatherViewModel.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation

final class CurrentWeatherViewModel: ObservableObject {
    @Published private(set) var dataSource: CurrentWeatherDTO?

    let city: String
    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(city: String, weatherFetcher: WeatherFetchable = WeatherNetworking()) {
        self.weatherFetcher = weatherFetcher
        self.city = city
    }

    func refresh() {
        disposables.dispose()

        weatherFetcher
            .currentWeatherForecast(forCity: city)
            .map(CurrentWeatherDTO.init)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = nil
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] weather in
                    guard let self = self else { return }
                    self.dataSource = weather
            })
            .store(in: &disposables)
    }
}

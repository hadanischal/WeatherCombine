//
//  WeatherListViewModel.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 4/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation

final class WeatherListViewModel: ObservableObject {
    @Published private(set) var cityIDs: [String] = OpenWeatherAPI.CityIDs
    @Published private(set) var dataSource: [WeatherListDTO] = []

    private let weatherFetcher: WeatherListFetchable
    private var disposables = Set<AnyCancellable>()

    init(
        weatherFetcher: WeatherListFetchable = WeatherNetworking(),
        scheduler: DispatchQueue = DispatchQueue(label: "WeatherListViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        $cityIDs
            .sink(receiveValue: fetchWeather(forCities:))
            .store(in: &disposables)
    }

    func fetchWeather(forCities cities: [String]) {
        disposables.dispose()

        weatherFetcher
            .getCurrentWeather(forCities: OpenWeatherAPI.CityIDs)
            .map { response in
                response.map(WeatherListDTO.init)
        }
        .map(Array.removeDuplicates)
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                    self.dataSource = []
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] forecast in
                guard let self = self else { return }
                self.dataSource = forecast
            }
        )
        .store(in: &disposables)
    }
}

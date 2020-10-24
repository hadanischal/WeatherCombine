//
//  WeeklyWeatherViewModel.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation

final class WeeklyWeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published private(set) var dataSource: [WeeklyWeatherDTO] = []

    private let weatherFetcher: WeatherFetchable
    private var disposables = Set<AnyCancellable>()

    init(
        weatherFetcher: WeatherFetchable = WeatherNetworking(),
        scheduler: DispatchQueue = DispatchQueue(label: "WeatherViewModel")
    ) {
        self.weatherFetcher = weatherFetcher
        $cityName
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchWeather(forCity:))
            .store(in: &disposables)
    }

    func fetchWeather(forCity city: String) {
        weatherFetcher
            .weeklyWeatherForecast(forCity: city)
            .map { response in
                response.list.map(WeeklyWeatherDTO.init)
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

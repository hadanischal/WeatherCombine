//
//  WeatherNetworking.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 20/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation

protocol WeatherFetchable: AnyObject {
  func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyWeatherResponse, NetworkError>
  func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherResponse, NetworkError>
}

final class WeatherNetworking: WeatherFetchable {
    private let networkService: NetworkServiceHandling

    init(networkService: NetworkServiceHandling = NetworkService()) {
        self.networkService = networkService
    }

    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyWeatherResponse, NetworkError> {
        guard let url = URL.forecastUrl else {
          return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        var components = OpenWeatherAPI.components
        components.updateValue(city, forKey: "q")

        let res: Resource<WeeklyWeatherResponse> = { Resource(url: url, parameter: components) }()
        return networkService.load(res)
    }

    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherResponse, NetworkError> {
        guard let url = URL.weatherUrl else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        var components = OpenWeatherAPI.components
        components.updateValue(city, forKey: "q")

        let res: Resource<CurrentWeatherResponse> = { Resource(url: url, parameter: components) }()
        return networkService.load(res)
    }
}

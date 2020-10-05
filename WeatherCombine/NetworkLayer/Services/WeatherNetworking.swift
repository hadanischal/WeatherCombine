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

protocol WeatherListFetchable: AnyObject {
    func getCurrentWeather(forCities cityIds: [String]) -> AnyPublisher<[CurrentWeatherResponse], NetworkError>
}

final class WeatherNetworking: WeatherFetchable, WeatherListFetchable {
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

    func getCurrentWeather(forCities cityIds: [String]) -> AnyPublisher<[CurrentWeatherResponse], NetworkError> {
        guard let url = URL.groupUrl else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        let components = self.buildQueryParams(withCityIds: cityIds)

        let res: Resource<CityWeatherListResponse> = { Resource(url: url, parameter: components) }()
        return networkService
            .load(res)
            .compactMap { $0.weatherList }
            .eraseToAnyPublisher()
    }

    // MARK: - Private Helpers

    private func buildQueryParams(withCityIds cityIds: [String]) -> [String: String] {
        return [
            "id": cityIds.joined(separator: ","),
            "units": OpenWeatherAPI.ApiConfig.weatherUnit,
            "APPID": OpenWeatherAPI.ApiConfig.apiKey
        ]
    }
}

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

typealias WeatherNetworkHandler = WeatherFetchable & WeatherListFetchable

final class WeatherNetworking: WeatherNetworkHandler {
    private let networkService: NetworkServiceHandling

    init(networkService: NetworkServiceHandling = NetworkService()) {
        self.networkService = networkService
    }

    func weeklyWeatherForecast(forCity city: String) -> AnyPublisher<WeeklyWeatherResponse, NetworkError> {
        guard let url = URL.forecastUrl else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        let request = WeatherRequest(city: city)
        let res: Resource<WeeklyWeatherResponse> = { Resource(url: url, parameter: request.parameter) }()
        return networkService.load(res)
    }

    func currentWeatherForecast(forCity city: String) -> AnyPublisher<CurrentWeatherResponse, NetworkError> {
        guard let url = URL.weatherUrl else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        let request = WeatherRequest(city: city)
        let res: Resource<CurrentWeatherResponse> = { Resource(url: url, parameter: request.parameter) }()
        return networkService.load(res)
    }

    func getCurrentWeather(forCities cityIds: [String]) -> AnyPublisher<[CurrentWeatherResponse], NetworkError> {
        guard let url = URL.groupUrl else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }

        let request = WeatherRequest(id: cityIds.joined(separator: ","))
        let res: Resource<CityWeatherListResponse> = { Resource(url: url, parameter: request.parameter) }()
        return networkService
            .load(res)
            .compactMap { $0.weatherList }
            .eraseToAnyPublisher()
    }
}

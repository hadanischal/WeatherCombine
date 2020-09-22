//
//  NetworkService.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 12/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import Foundation

protocol NetworkServiceHandling: AnyObject {
    func load<T: Decodable>(_ resource: Resource<T>) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceHandling {
    private let session: URLSession

    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        return decoder
    }

    init(session: URLSession = .shared) {
        self.session = session
    }

    func load<T: Decodable>(_ resource: Resource<T>) -> AnyPublisher<T, NetworkError> {
        let request = resource.urlRequest

        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                self.decode(pair.data)
            }
            .eraseToAnyPublisher()
    }

    private func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}

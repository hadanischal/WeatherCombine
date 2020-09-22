//
//  Resource.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 12/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

struct Resource<T: Decodable> {
    let url: URL
    let parameter: [String: CustomStringConvertible]?
}

extension Resource {
    var urlRequest: URLRequest {
        return URLRequest(url: componentsUrl ?? url)
    }

    var componentsUrl: URL? {
        if
            let parameters = parameter,
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            components.queryItems = parameters.map { (arg) -> URLQueryItem in
                let (key, value) = arg
                return URLQueryItem(name: key, value: value.description)
            }
            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
            return components.url
        }
        return nil
    }
}

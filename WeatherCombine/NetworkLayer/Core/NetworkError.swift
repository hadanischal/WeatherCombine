//
//  NetworkError.swift
//  ReduxAnime
//
//  Created by Nischal Hada on 21/6/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

/// Defines the Network service errors.
enum NetworkError: Error {
    case parsing(description: String)
    
    case network(description: String)

    /// When netowrk cannot be established
    case networkFailure

    /// When network request has timed out
    case timeout

    // MARK: - Server / Authentication

    /// When returns 5xx family of server errors
    case server

    /// When service is unaavailable. i.e. 503
    case seviceUnavailable

    /// When api returns rate limited error. i.e. 429
    case apiRateLimited

    /// When unauthoized due to bad credentials. i.e. 401
    case unAuthorized

    /// When access is forbidden i.e. 403
    case forbidden

    /// When api service is not found. i.e. 404
    case notFound

    // MARK: - Misc

    /// When api does not return data
    case noDataFound

    /// When JSON data mapping/conversion error
    case jsonDecodingError(error: Error)

    /// Url is invalid error.
    case badURL

    /// Any unknown error happens
    case unknown
}

// MARK: - Custom Error Mapping Helpers

extension NetworkError {
    /// Maps an Error from potential NSError from network connectivity issues
    static func mapConnectivityError(_ error: Error) -> NetworkError {
        let networkError: NSError = error as NSError
        switch networkError.code {
        case NSURLErrorNotConnectedToInternet:
            return .networkFailure
        case NSURLErrorTimedOut:
            return .timeout
        default:
            return .unknown
        }
    }

    /// Maps an HTTP negative status code into an custom error enum via `NetworkError`
    static func mapHTTPStatusError(statusCode: Int) -> NetworkError {
        switch statusCode {
        case 401:
            return .unAuthorized
        case 403:
            return .forbidden
        case 404:
            return .notFound
        case 429:
            return .apiRateLimited
        case 503:
            return .seviceUnavailable
        case 500 ... 599:
            return .server
        default:
            return .unknown
        }
    }
}

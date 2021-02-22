//
//  Encoder+Extensions.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 26/1/21.
//  Copyright © 2021 Nischal Hada. All rights reserved.
//

import Foundation

typealias Parameters = [String: String]

protocol EncoderProtocol: Encodable {
    var parameter: Parameters? { get }
}

extension EncoderProtocol {
    var parameter: Parameters? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted

        guard let data = try? jsonEncoder.encode(self) else { return nil }

        let jsonObject = try? JSONSerialization.jsonObject(
            with: data,
            options: .allowFragments
        )
        let params = jsonObject as? Parameters
        return params ?? [:]
    }
}

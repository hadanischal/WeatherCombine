//
//  Cancellable+Extensions.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 15/11/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

/// Taken from here: https://stackoverflow.com/a/62076775, https://stackoverflow.com/questions/59002502/ios-swift-combine-cancel-a-setanycancellable

import Combine

typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}

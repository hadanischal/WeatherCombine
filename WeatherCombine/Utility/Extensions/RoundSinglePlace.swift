//
//  DoubleExtension.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 22/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the single to decimal places value
    var roundSinglePlace: String {
        String(format: "%.1f", self)
    }
}

extension Int {
    /// Rounds the single to decimal places value
    var roundSinglePlace: String {
        String(format: "%.1f", self)
    }
}

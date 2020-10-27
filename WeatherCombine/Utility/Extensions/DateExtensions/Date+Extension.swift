//
//  Date+Extension.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 25/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

extension Date {
    var ddMMyyyyString: String {
        DateFormatter.sharedDateFormatter.string(from: self)
    }
}

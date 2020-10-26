//
//  XCTestCase+Extension.swift
//  WeatherCombineTests
//
//  Created by Nischal Hada on 24/10/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Combine
import XCTest

typealias CompetionResult = (expectation: XCTestExpectation,
                             cancellable: AnyCancellable)

extension XCTestCase {
    func expectValue<T: Publisher>(of publisher: T,
                                   timeout: TimeInterval = 2,
                                   file: StaticString = #file,
                                   line: UInt = #line,
                                   equals: [(T.Output) -> Bool])
        -> CompetionResult {
            let exp = expectation(description: "Correct values of " + String(describing: publisher))
            var mutableEquals = equals
            let cancellable = publisher
                .sink(receiveCompletion: { _ in },
                      receiveValue: { value in
                        if mutableEquals.first?(value) ?? false {
                            _ = mutableEquals.remove(at: 0)
                            if mutableEquals.isEmpty {
                                exp.fulfill()
                            }
                        }
                })
            return (exp, cancellable)
    }
}

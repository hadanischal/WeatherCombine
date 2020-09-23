//
//  Scheduler.swift
//  WeatherCombine
//
//  Created by Nischal Hada on 12/9/20.
//  Copyright © 2020 Nischal Hada. All rights reserved.
//

import Foundation

final class Scheduler {
    static var background: OperationQueue = {
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 5
        operationQueue.qualityOfService = QualityOfService.userInitiated
        return operationQueue
    }()

    static let main = RunLoop.main
}

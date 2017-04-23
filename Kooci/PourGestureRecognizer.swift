//
//  PourGestureRecognizer.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/23/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

class PourGestureRecognizer: GestureRecognizer {
    
    var timeIntervalNeeded: TimeInterval = 3.0
    
    var startDate: Date?
    
    func state(for frames: [AccelerometerData]) -> GestureState {
        guard let frame = frames.last else {
            return .stale
        }
        if let startDate = startDate {
            if Date().timeIntervalSince(startDate) > timeIntervalNeeded {
                return .done
            } else {
                return .inProgress
            }
        } else {
            if frame.y < -0.2 {
                startDate = Date()
                return .inProgress
            } else {
                return .stale
            }
        }
    }
    
}

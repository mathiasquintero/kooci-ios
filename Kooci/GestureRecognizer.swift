//
//  Gesture.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

protocol GestureRecognizer {
    func state(for frames: [AccelerometerData]) -> GestureState
}

extension Array {
    
    func from(index: Int) -> [Element] {
        guard index < count else {
            return []
        }
        return self[(index..<count)].map { $0 }
    }
    
}

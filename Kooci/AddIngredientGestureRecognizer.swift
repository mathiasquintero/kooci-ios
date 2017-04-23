//
//  AddIngredientGestureRecognizer.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/23/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

class AddingIngredientGestureRecognizer: GestureRecognizer {
    
    var didRecognize = false
    
    func state(for frames: [AccelerometerData]) -> GestureState {
        guard !didRecognize else {
            return .done
        }
        guard frames.count > 1 else {
            return .stale
        }
        let last = frames[frames.count - 2]
        let now = frames[frames.count - 1]
        if abs(last.y) > 0.2 && abs(now.z) > 0.6 {
            didRecognize = true
            return .done
        } else {
            return .stale
        }
    }
    
}

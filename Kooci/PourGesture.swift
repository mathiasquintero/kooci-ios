//
//  PourGesture.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

class PourGesture: Gesture {
    
    var amountLeft: Int
    
    init(amount: Int) {
        self.amountLeft = amount
    }
    
    func state(for frames: [AccelerometerData]) -> GestureState {
        // TODO: Recognize Gesture
        return .stale
    }
    
}

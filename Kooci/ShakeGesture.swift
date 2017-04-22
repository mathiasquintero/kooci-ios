//
//  ShakeGesture.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

class ShakeGesture: SimpleGesture {
    
    var times: Int
    
    var state: GestureState = .stale
    var index = 0
    lazy var subgestures: [Subgesture] = {
        return (0..<self.times).flatMap { _ in [.swipeDown, .swipeUp] }
    }()
    
    init(times: Int) {
        self.times = times
    }
    
}

//
//  Gesture.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

protocol Gesture {
    func state(for frames: [AccelerometerData]) -> GestureState
}

protocol SimpleGesture: class, Gesture {
    var state: GestureState { get set }
    var index: Int { get set }
    var subgestures: [Subgesture] { get set }
}

extension SimpleGesture {
    
    func internalState(for frames: [AccelerometerData]) -> GestureState {
        guard let gesture = subgestures.first else {
            return .done
        }
        let frames = frames.from(index: index)
        guard let classified = Classifier.shared.gestureFor(frames: frames) else {
            return state
        }
        if gesture == classified {
            subgestures.remove(at: 0)
        } else {
            return .stale
        }
        return .inProgress
    }
    
    func state(for frames: [AccelerometerData]) -> GestureState {
        let state = internalState(for: frames)
        self.state = state
        return state
    }
    
}

extension Array {
    
    func from(index: Int) -> [Element] {
        guard index < count else {
            return []
        }
        return self[(index..<count)].map { $0 }
    }
    
}

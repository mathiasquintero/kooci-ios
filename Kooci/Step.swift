//
//  Step.swift
//  kooci
//
//  Created by Ute Schiehlen on 23.04.17.
//  Copyright © 2017 Ute Schiehlen. All rights reserved.
//

import Foundation

enum Gesture {
    case addIngredient
    case stir
    case pour
}

extension Gesture {
    
    func gestureRecognizer() -> GestureRecognizer {
        switch self {
        case .addIngredient:
            return AddingIngredientGestureRecognizer()
        case .stir:
            return StirringGestureRecognizer()
        case .pour:
            return PourGestureRecognizer()
        }
    }
    
}

struct Step {
    let text: String
    let gestures: [Gesture]
}

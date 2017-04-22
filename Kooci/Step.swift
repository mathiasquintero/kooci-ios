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

struct Step {
    let text: String
    let gestures: [Gesture]
}

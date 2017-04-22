//
//  Recipe.swift
//  kooci
//
//  Created by Ute Schiehlen on 23.04.17.
//  Copyright © 2017 Ute Schiehlen. All rights reserved.
//

import Foundation

class Recipe {
    
    var steps = [Step]()
    var name: String
    
    var currentStep = 0
    
    public init(name: String, steps: [Step]) {
        self.name = name
        self.steps = steps
    }
    
    func start() {
        
    }
}

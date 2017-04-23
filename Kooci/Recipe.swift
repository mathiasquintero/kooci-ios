//
//  Recipe.swift
//  kooci
//
//  Created by Ute Schiehlen on 23.04.17.
//  Copyright © 2017 Ute Schiehlen. All rights reserved.
//

import Foundation

protocol RecipeDelegate {
    func didFinish(recipe: Recipe)
    
    func sayInstruction(text: String)
}

class Recipe {
    
    var steps = [Step]()
    var name: String
    var currentStep = 0

    let gestureManager = GestureManager()
    var delegate: RecipeDelegate?
    
    public init(name: String, steps: [Step]) {
        self.name = name
        self.steps = steps
    }
    
    func start() {
        currentStep = 0
        gestureManager.delegate = self
        gestureManager.start()
        nextStep()
    }
    
    fileprivate func nextStep() {
        let step = steps[currentStep]
        gestureManager.gesture = step.gesture?.gestureRecognizer()
    }
}

// gesture delegate
extension Recipe: GestureDelegate {
    func gestureManager(_ manager: GestureManager, didFinish gesture: GestureRecognizer) {
        // say text
        if let instruction = steps[currentStep].text {
            delegate?.sayInstruction(text: instruction)
        }
        
        // do next step if step was not last step
        currentStep += 1
        if currentStep < steps.count {
            nextStep()
        } else {
            // recipe finished
            // set idle to true and start listening again
            delegate?.didFinish(recipe: self)
        }
    }
}

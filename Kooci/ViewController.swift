//
//  ViewController.swift
//  kooci
//
//  Created by Ute Schiehlen on 22.04.17.
//  Copyright © 2017 Ute Schiehlen. All rights reserved.
//

import UIKit
import Pulsator

class ViewController: UIViewController {
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var watsonService = WatsonServices()
    var pulsatorMaxRadius: CGFloat = 0
    let pulsatorMaxDuration = 10.0
    let pulsatorMaxInvarval = 5.0
    let pulsatorNumPulse = 4
    
    var recipes = [Recipe]()
    var idle = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pulsatorMaxRadius = view.frame.width/2
        createMojito()
        
        startWatson()
        
        addPulsator()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func addPulsator() {
        let sourceView = UIView()
        sourceView.frame = CGRect(x: view.frame.midX-20, y: view.frame.midY-20, width: view.frame.width/8,
                                  height: view.frame.width/8)
        sourceView.backgroundColor = .clear
        view.addSubview(sourceView)
        
        let pulsator = Pulsator()
        pulsator.backgroundColor = UIColor.white.cgColor
        pulsator.numPulse = pulsatorNumPulse
        pulsator.radius = pulsatorMaxRadius
        pulsator.animationDuration = pulsatorMaxDuration
        //pulsator.pulseInterval = pulsatorMaxInterval
        pulsator.position = sourceView.layer.position
        sourceView.layer.superlayer?.insertSublayer(pulsator, below: sourceView.layer)
        
        pulsator.start()
    }
    
    private func startWatson() {
        let text = "Hi I'm kuki!"
        watsonService.speak(text: text){success in
            if success {
                self.startListening()
            }
        }
    }
    
    fileprivate func startListening() {
        watsonService.startStreaming(completion: { result in
            // get recipe
            for recipe in self.recipes {
                let startTrigger = recipe.name.lowercased()
                let lowerResult = result.lowercased()
                if lowerResult.contains(startTrigger) || lowerResult.contains("please") {
                    // recipe name detected
                    if self.idle {
                        self.idle = false
                        self.watsonService.stopStreaming()
                        recipe.start()
                    }
                }
            }
        })
    }
    
    private func createMojito() {
        let name = "Mojito"
        let step1 = Step(text: "Start by putting three mint leaves and two tea spoons of sugar in your glass.", gesture: .addIngredient)    // 3 mint leaves
        let step1_2 = Step(text: nil, gesture: .addIngredient)  // spoon of sugar
        let step1_3 = Step(text: nil, gesture: .addIngredient)  // spoon of sugar
        let step2 = Step(text: "Now add three lime wedges and stir it so we get all the good flavors.", gesture: .addIngredient)    // add wedges
        let step2_2 = Step(text: nil, gesture: .stir)   //stir all
        let step3 = Step(text: "Perfekt. Now we can add the rum. Just start pouring, I will tell you when to stop.", gesture: .pour)    // pouring 2 seconds
        let step4 = Step(text: "Stop. Now add sparkling water until the glass is full and a dash of sugar for good measure. Enjoy your drink!", gesture: nil)
        let steps = [step1, step1_2, step1_3, step2, step2_2, step3, step4]
        let recipe = Recipe(name: name, steps: steps)
        recipe.delegate = self
        recipes.append(recipe)
    }
}

extension ViewController: RecipeDelegate {
    func didFinish(recipe: Recipe) {
        // start listening again
        idle = true
//        startListening()
    }
    
    func progressChanged(_ recipe: Recipe) {
        progressView.setProgress(recipe.progress, animated: true)
    }
    
    func sayInstruction(text: String) {
        watsonService.speak(text: text) { success in
            if success {
                print("Just said: \(text)")
            }
        }
    }
}

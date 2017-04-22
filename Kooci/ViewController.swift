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
    
    let watsonService = WatsonServices()
    var pulsatorMaxRadius: CGFloat = 0
    let pulsatorMaxDuration = 10.0
    let pulsatorMaxInterval = 5.0
    let pulsatorNumPulse = 4
    
    let recipes = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pulsatorMaxRadius = view.frame.width/2
        
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
                self.watsonService.startStreaming(){ result in
                    // get recipe
                    for recipe in self.recipes {
                        let startTrigger = recipe.name.lowercased()
                        let lowerResult = result.lowercased()
                        if lowerResult.contains(startTrigger) {
                            recipe.start()
                            self.watsonService.stopStreaming()
                        }
                    }
                }
            }
        }
    }
}


//
//  ViewController.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gestureManager = GestureManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureManager.start()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: GestureDelegate {
    
    func gestureManager(_ manager: GestureManager, didChangeState: GestureState) {
        
    }
    
}

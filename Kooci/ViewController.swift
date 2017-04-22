//
//  ViewController.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    let broker = MessageBroker<ViewController>()

    override func viewDidLoad() {
        super.viewDidLoad()
        broker.start()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: MessageReceiver {
    
    typealias Message = AccelerometerInformation
    
    static var uuid: UUID {
        return UUID(uuidString: "226834ae-786e-4302-a52f-6e7efc9f990b")!
    }
    
    func broker(_ broker: MessageBroker<ViewController>, didReceive message: AccelerometerInformation) {
        
    }
    
}

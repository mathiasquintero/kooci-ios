//
//  GestureManager.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

final class GestureManager: NSObject {
    
    var data = [AccelerometerData]()
    
    var gesture: Gesture?
    var broker = MessageBroker<GestureManager>()
    
    func start() {
        broker.receiver = self
        broker.start()
    }
    
}

extension GestureManager: MessageReceiver {
    
    static var uuid: UUID {
        return UUID(uuidString: "8CB491E3-4A2E-4094-8B04-17F6954F99C5")!
    }
    
    func broker(_ broker: MessageBroker<GestureManager>, didReceive message: AccelerometerData) {
        
    }
    
}

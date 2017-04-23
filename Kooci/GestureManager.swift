//
//  GestureManager.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

final class GestureManager: NSObject {
    
    var gravity = AccelerometerData(x: 0, y: 0, z: 0)
    
    weak var delegate: GestureDelegate?
    var data = [AccelerometerData]()
    
    var state: GestureState?
    var gesture: GestureRecognizer? {
        didSet {
            data.removeAll()
        }
    }
    
    var broker = MessageBroker<GestureManager>()
    
    func modify(data: AccelerometerData) -> AccelerometerData {
        let alpha: Float = 0.8
        gravity = alpha * gravity + (1 - alpha) * data
        return data - gravity
    }
    
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
        let acceleration = modify(data: message)
//        print(acceleration)
        data.append(acceleration)
        guard let gesture = gesture else {
            return
        }
        let state = gesture.state(for: data)
        if self.state != nil, self.state != state {
//            print("Change to \(state)")
        }
    }
    
}

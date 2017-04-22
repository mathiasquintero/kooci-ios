//
//  AccelerometerData.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

struct AccelerometerInformation {
    
    struct AccelerometerData {
        let x: Int
        let y: Int
        let z: Int
    }
    
    let before: AccelerometerData
    let after: AccelerometerData
    
}

extension AccelerometerInformation: PebbleDeserializable {
    
    init?(from message: [NSNumber : Any]) {
        guard let firstArray = message[0] as? [Any],
            let secondArray = message[1] as? [Any],
            let before = AccelerometerData(data: firstArray),
            let after = AccelerometerData(data: secondArray) else {
                
                return nil
        }
        self.init(before: before, after: after)
    }
    
}

extension AccelerometerInformation.AccelerometerData {
    
    init?(data: [Any]) {
        guard let x = data[0] as? Int,
            let y = data[1] as? Int,
            let z = data[2] as? Int else {
                
                return nil
        }
        self.init(x: x, y: y, z: z)
    }
    
}

extension AccelerometerInformation {
    
    var isGoingUp: Bool {
        return true
    }
    
    var isGoingDown: Bool {
        return true
    }
    
    var isGoingLeft: Bool {
        return true
    }
    
    var isGoingRight: Bool {
        return true
    }
    
}

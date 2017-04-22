//
//  AccelerometerData.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

struct AccelerometerData {
    let x: Float
    let y: Float
    let z: Float
}


extension AccelerometerData: PebbleDeserializable {
    
    init?(from data: [NSNumber : Any]) {
        guard let x = data[0] as? Int,
            let y = data[1] as? Int,
            let z = data[2] as? Int else {
                
                return nil
        }
        self.init(x: min(Float(x) / 1000, 10.0), y: min(Float(y) / 1000, 10.0), z: min(Float(z) / 1000, 10.0))
    }
    
}

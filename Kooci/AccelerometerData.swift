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
    
    let data: [AccelerometerData]
    
}

extension AccelerometerInformation: PebbleDeserializable {
    
    init?(from message: [NSNumber : Any]) {
        return nil
    }
    
}

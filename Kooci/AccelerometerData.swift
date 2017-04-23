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

extension AccelerometerData {
    
    var norm: Float {
        return sqrt(x * x + y * y + z * z)
    }
    
    var isStable: Bool {
        return x < 0.01 && y < 0.01 && z < 0.01
    }
    
}

func +(lhs: AccelerometerData, rhs: AccelerometerData) -> AccelerometerData {
    return AccelerometerData(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
}

func -(lhs: AccelerometerData, rhs: AccelerometerData) -> AccelerometerData {
    return AccelerometerData(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
}

func *(lhs: Float, rhs: AccelerometerData) -> AccelerometerData {
    return AccelerometerData(x: lhs * rhs.x, y: lhs * rhs.y, z: lhs * rhs.z)
}

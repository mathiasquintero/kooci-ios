//
//  Subgesture.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation
import Bayes

enum Subgesture: Int {
    case swipeLeft
    case swipeRight
    case swipeUp
    case swipeDown
    case circleClockwise
    case circleCounterClockwise
    case boxClockwise
    case boxCounterClockwise
    case upAndRight
    case upAndLeft
    case rightAndDown
    case leftAndDown
    case vToRight
    case vToLeft
    case upsideDownVToRight
    case upsideDownVToLeft
    case sDown
    case backwardsSDown
    case sUp
    case backwardsSUp
}

struct TestData {
    var data: [Subgesture : [[AccelerometerData]]]
}

func arrayOfAccelerometerData(from url: URL) -> [AccelerometerData] {
    guard let data = try? Data(contentsOf: url), let file = String(data: data, encoding: .utf8) else {
        return []
    }
    let lines = file.components(separatedBy: "\n")
    return lines.flatMap { line in
        let items = line.components(separatedBy: " ")
        guard line != "", let x = Float(items[3]), let y = Float(items[4]), let z = Float(items[5]) else {
            return nil
        }
        return .init(x: x, y: y, z: z)
    }
}

extension TestData {
    
    init(filePath: URL) {
        data = [:]
        for set in (1...8) {
            let trainingSetURL = filePath.appendingPathComponent("U0\(set)")
            for gestureId in (1...20) {
                guard let gesture = Subgesture(rawValue: gestureId - 1) else {
                    continue
                }
                data[gesture] = data[gesture] ?? []
                let gestureURL = trainingSetURL.appendingPathComponent(String(format: "%02d", gestureId))
                for example in (1...20) {
                    let exampleURL = gestureURL.appendingPathComponent(String(format: "%02d.txt", example))
                    data[gesture]?.append(arrayOfAccelerometerData(from: exampleURL))
                }
            }
        }
    }
    
}

extension TestData {
    
    func classifier() -> BayesianClassifier<Subgesture, Float> {
        var eventSpace = EventSpace<Subgesture, Float>()
        data.forEach { item in
            let label = item.key
            item.value.forEach { set in
                let values = set.flatMap { [$0.x, $0.y, $0.z] }
                eventSpace.observe(label, features: values)
            }
        }
        return BayesianClassifier(eventSpace: eventSpace)
    }
    
}

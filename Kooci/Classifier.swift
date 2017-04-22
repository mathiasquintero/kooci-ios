//
//  Classifier.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation
import Bayes

class Classifier {
    
    enum ClassificationResult {
        case maybe(Subgesture)
        case inProgress([Subgesture])
        case nothingByALongShot
    }
    
    static var shared: Classifier = {
        let url = Bundle.main.url(forResource: "gestures-dataset", withExtension: nil)!
        let test = TestData.init(filePath: url)
        return Classifier(classifier: test.classifier())
    }()
    
    private var internalClassifier: BayesianClassifier<Subgesture, Float>
    
    init(classifier: BayesianClassifier<Subgesture, Float>) {
        self.internalClassifier = classifier
    }
    
    func gestureFor(frames: [AccelerometerData]) -> ClassificationResult {
        let values = frames.flatMap { [$0.x, $0.y, $0.z] }
        let probabilities = internalClassifier.categoryProbabilities(values.makeIterator()).sorted { $0.1 > $1.1 }
        print(probabilities)
        if let first = probabilities.first, first.value > 0.5 {
            return .maybe(first.key)
        }
        let maybes = probabilities.filter { $0.value > 0 }
        if maybes.count > 0 {
            return .inProgress(maybes.map { $0.key })
        }
        return .nothingByALongShot
    }
    
}

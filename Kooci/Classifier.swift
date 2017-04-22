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
    
    static var shared: Classifier = {
        let url = Bundle.main.url(forResource: "gestures-dataset", withExtension: nil)!
        let test = TestData.init(filePath: url)
        return Classifier(classifier: test.classifier())
    }()
    
    private var internalClassifier: BayesianClassifier<Subgesture, Float>
    
    init(classifier: BayesianClassifier<Subgesture, Float>) {
        self.internalClassifier = classifier
    }
    
    func gestureFor(frames: [AccelerometerData]) -> Subgesture? {
        let values = frames.flatMap { [$0.x, $0.y, $0.z] }
        let probabilities: [Subgesture : Double] = internalClassifier.categoryProbabilities(values.makeIterator())
        return probabilities.filter { $1 > 0.7 }
                            .sorted { $0.1 > $1.1 }
                            .map { $0.0 }
                            .first
    }
    
}

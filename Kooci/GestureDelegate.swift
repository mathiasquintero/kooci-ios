//
//  GestureDelegate.swift
//  Gurke
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

protocol GestureDelegate: class {
    func gestureManager(_ manager: GestureManager, didFinish gesture: GestureRecognizer?)
}

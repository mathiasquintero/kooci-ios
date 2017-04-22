//
//  PebbleDeserializable.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation

protocol PebbleDeserializable {
    init?(from message: [NSNumber : Any])
}

protocol MessageReceiver: class {
    associatedtype Message: PebbleDeserializable
    func broker(_ broker: MessageBroker<Self>, didReceive message: Message)
}

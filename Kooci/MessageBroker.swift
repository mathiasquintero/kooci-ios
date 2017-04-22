//
//  MessageReceiver.swift
//  Kooci
//
//  Created by Mathias Quintero on 4/22/17.
//  Copyright © 2017 Mathias Quintero. All rights reserved.
//

import Foundation
import PebbleKit

class MessageBroker<Receiver: MessageReceiver>: NSObject, PBPebbleCentralDelegate {
    
    weak var receiver: Receiver?
    var watch: PBWatch? {
        didSet {
            watch?.appMessagesAddReceiveUpdateHandler { [unowned self] (watch, update) in
                guard let message = Receiver.Message(from: update) else {
                    return false
                }
                self.receiver?.broker(self, didReceive: message)
                return true
            }
        }
    }
    
    lazy var manager: PBPebbleCentral = {
        let manager = PBPebbleCentral.default()
        manager.delegate = self
        manager.appUUID = Receiver.uuid
        return manager
    }()
    
    func start() {
        manager.run()
    }
    
    func pebbleCentral(_ central: PBPebbleCentral, watchDidConnect watch: PBWatch, isNew: Bool) {
        self.watch = watch
    }
    
    func pebbleCentral(_ central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        if self.watch == watch {
            self.watch = nil
        }
    }
    
}

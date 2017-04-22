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
    var watch: PBWatch?
    
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
        let update: [NSNumber : Any] = [ 0 : "test" ]
        watch.appMessagesPushUpdate(update, with: Receiver.uuid) { (watch, update, error) in
            print(watch.isConnected)
        }
        watch.appMessagesAddReceiveUpdateHandler({ (watch, update) in
            print("Did receive update from watch")
            guard let message = Receiver.Message(from: update) else {
                return true
            }
            self.receiver?.broker(self, didReceive: message)
            return true
        }, with: Receiver.uuid)
    }
    
    func pebbleCentral(_ central: PBPebbleCentral, watchDidDisconnect watch: PBWatch) {
        if self.watch == watch {
            self.watch = nil
        }
    }
    
}

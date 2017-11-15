//
//  EventManagerController.swift
//  EventShare
//
//  Created by Kevin NGUYEN on 31/10/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//
import Foundation
import EventKit

class ListOfEvents {
    
    var events: [Event]
    
    init(inforEvent: [Event]) {
        self.events = inforEvent
    }
    
    class func eventsList() -> [ListOfEvents] {
        return [self.event()]
    }
    
    private class func event() -> ListOfEvents {
        let events = [Event]()
        //events.append(Event(titled: "test", desc: "test"))
        return ListOfEvents(inforEvent: events)
    }
}

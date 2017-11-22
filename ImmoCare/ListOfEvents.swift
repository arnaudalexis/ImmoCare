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
}// class

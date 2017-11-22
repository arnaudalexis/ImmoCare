import Foundation
import UIKit
import EventKit

class EventHandler {
    
    private static let _instance = EventHandler();
    
    static var instance : EventHandler {
        return _instance;
    }
    
    // add event into calendar's apple app
    func addEvent(title: String, msg: String, start: String, end: String) {
        
        let eventStore:EKEventStore = EKEventStore()
        
        // get access to calendar's apple app
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            
            if(granted) && (error == nil)
            {
                print("granted \(granted)");
                print("error \(String(describing: error))");
                
                let startDate = self.stringToDate(start)
                let endDate = self.stringToDate(end)
                
                // save data event into calendar's apple app
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = msg
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                }catch let error as NSError {
                    print("error \(error)")
                }
            }
            else{
                print("error: \(String(describing: error))")
            }
        })
    } // function addEvent
    
    // convert string date to date
    func stringToDate(_ str: String)->Date{
        let formatter = DateFormatter()
        formatter.dateFormat="MMM d, yyyy"
        let locale = NSTimeZone.init(abbreviation: "UTC")
        NSTimeZone.default = locale! as TimeZone
        
        return formatter.date(from: str)!
    } // function stringToDate
    
} // class

//
//  EventAddingViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 07/11/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
import EventKit

class EventAddingViewController: UIViewController {
    
    var calendar: EKCalendar!
    var data: Data?
    
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var eventStartDatePicker: UIDatePicker!
    @IBOutlet weak var eventEndDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.eventStartDatePicker.setDate(initialDatePickerValue(), animated: false)
        self.eventEndDatePicker.setDate(initialDatePickerValue(), animated: false)
    }
    
    func getData(data: Data) {
        self.data = data
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        // Create an Event Store instance
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
        if let calendarForEvent = eventStore.calendar(withIdentifier: self.calendar.calendarIdentifier)
        {
            let newEvent = EKEvent(eventStore: eventStore)
            
            newEvent.calendar = calendarForEvent
            newEvent.title = self.eventNameTextField.text ?? "Some Event Name"
            newEvent.startDate = self.eventStartDatePicker.date
            newEvent.endDate = self.eventEndDatePicker.date
            
            // Save the event using the Event Store instance
            do {
                try eventStore.save(newEvent, span: .thisEvent, commit: true)
                
                self.dismiss(animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
}

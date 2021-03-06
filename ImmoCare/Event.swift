import Foundation

class Event {
    
    var title: String
    var description: String
    var startDate: String
    var endDate: String
    
    init(titled: String, desc: String, startDated: String, endDated: String) {
        self.title = titled
        self.description = desc
        self.startDate = startDated
        self.endDate = endDated
    }
} // class

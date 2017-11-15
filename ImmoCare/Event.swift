//
//  EventManagerController.swift
//  EventShare
//
//  Created by Kevin NGUYEN on 31/10/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

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
}

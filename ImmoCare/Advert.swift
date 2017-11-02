//
//  Advert.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 19/10/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class Advert {
    
    //MARK: Properties
    
    var title: String
    var date: String
    var author: String
    
    //MARK: Initialization
    
    init?(title: String, date: String, author: String) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.title = title
        self.date = date
        self.author = author
        
    }
}


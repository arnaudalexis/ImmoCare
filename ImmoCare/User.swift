//
//  User.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 19/10/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit
import SwiftyJSON


// {"id":1,"name":null,"firstname":null,"email":"Test@test.com","city":null,"creation_date":"2017-09-08T07:10:08.000Z","type":0,"note":0,"nb_note":0}

class User {
    
    //MARK: Properties
    var id: Int
    var name: String
    var firstname: String
    var email: String
    var city: String
    var creation_date: String
    var type: Int
    var note: Int
    var nb_note: Int
    var phone: String
    
    static let sharedInstance = User()
    
    static func sharedInstanceWith(json: JSON) -> User {
        let instance = User.sharedInstance
        instance.id = json["id"].intValue
        instance.name = json["name"].stringValue
        instance.firstname = json["firstname"].stringValue
        instance.email = json["email"].stringValue
        instance.city = json["city"].stringValue
        instance.creation_date = json["creation_date"].stringValue
        instance.type = json["type"].intValue
        instance.note = json["note"].intValue
        instance.nb_note = json["nb_note"].intValue
        instance.phone = json["phone"].stringValue
        return instance
    }
    
    
    
    
    //MARK: Initialization
    
    init() {
        
        self.id = -1
        self.name = ""
        self.firstname = ""
        self.email = ""
        self.city = ""
        self.creation_date = ""
        self.type = -1
        self.note = -1
        self.nb_note = -1
        self.phone = ""
    }
}

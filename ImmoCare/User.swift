//
//  User.swift
//  ImmoCare
//
//  Created by Alexis Arnaud on 19/10/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit


// {"id":1,"name":null,"firstname":null,"email":"Test@test.com","city":null,"creation_date":"2017-09-08T07:10:08.000Z","type":0,"note":0,"nb_note":0}

class User {
    
    //MARK: Properties
    let id: Int
    let name: String
    let firstname: String
    let email: String
    let city: String
    let creation_date: String
    let type: Int
    let note: Int
    let nb_note: Int
    
    
    
    //MARK: Initialization
    
    init?(json: JSON) {
        print(json);

        
        id = json["id"].intValue
            name = json["name"].stringValue
            firstname = json["firstname"].stringValue
            email = json["email"].stringValue
            city = json["city"].stringValue
            creation_date = json["creation_date"].stringValue
            type = json["type"].intValue
            note = json["note"].intValue
            nb_note = json["nb_note"].intValue
        
    }
}

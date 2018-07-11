//
//  EditProfileViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 10/07/2018.
//  Copyright © 2018 ImmoCare. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var editCityFieldText: UILabel!
    @IBOutlet weak var editEmailFieldText: UILabel!
    @IBOutlet weak var editTelFieldText: UILabel!
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        print("Cancel clicked!")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtn(_ sender: Any) {
       print("done clicked!")
    }
    
    func updateUserProfile()  {
    
    }
    
}

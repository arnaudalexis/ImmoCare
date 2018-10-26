//
//  ProfileViewController.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 22/11/2017.
//  Copyright © 2017 ImmoCare. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descriptionView: UITextView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let user = User.sharedInstance
        
        nameLabel.text = user.firstname.capitalizingFirstLetter() + " " + user.name.capitalizingFirstLetter()
        cityLabel.text = user.city
        emailLabel.text = user.email
        typeLabel.text = (user.type == 0 ? "Vacancier" : "Gardien")
        //setupMenuBar()
    }
    
    let menuBar : MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]|", views: menuBar)
    }
    
    // edit profile btn
    @IBAction func editProfileBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "editProfileSegue", sender: self)
    }
    
    // logout btn
    @IBAction func logoutBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
    }
    
} // class

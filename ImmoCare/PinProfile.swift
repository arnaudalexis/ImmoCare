//
//  PinProfile.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 11/07/2018.
//  Copyright © 2018 ImmoCare. All rights reserved.
//

import UIKit
import MapKit

class PinProfileViewController: UIViewController {
    
    var viaSegue = MKAnnotationView()
    var dataDict:[String:String] = [:]
    var nameStr:String = "nom"
    var cityStr:String = ""
    var emailStr:String = ""
    var typeStr:String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameStr
        cityLabel.text = cityStr
        emailLabel.text = emailStr
        typeLabel.text = typeStr
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    
}

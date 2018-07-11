//
//  PinProfile.swift
//  ImmoCare
//
//  Created by Kevin NGUYEN on 11/07/2018.
//  Copyright © 2018 ImmoCare. All rights reserved.
//

import UIKit
import MapKit

class PinProfileViewController: UITableViewController, MKMapViewDelegate {
    
    var viaSegue = MKAnnotationView()
    var dataDict:[String:String] = [:]
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
    }
    
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  PinAnnotation.swift
//  mapkitTest
//
//  Created by Kevin NGUYEN on 16/05/2018.
//  Copyright © 2018 etna. All rights reserved.
//

import MapKit

class PinAnnotation: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var userDistance: String?
    var image: UIImage?
    var data: AnyObject?
    
    init(title : String, subtitle: String, coordinate: CLLocationCoordinate2D, data: AnyObject) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.data = data
    }
}

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
    
    init(title : String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

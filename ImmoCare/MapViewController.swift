//
//  MapViewController.swift
//  mapkitTest
//
//  Created by Kevin NGUYEN on 15/05/2018.
//  Copyright © 2018 etna. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Foundation


var idUser:String!
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var selectedAnnotation: PinAnnotation?
    var selName:String = ""
    var selCity:String = ""
    var selEmail:String = ""

    @IBOutlet weak var switchRole: UILabel!
    @IBOutlet weak var travelRadius: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var swicther: UISwitch!
    
    var regionHasBeenCentered = false
    let locationManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        if !regionHasBeenCentered {
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            //let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(48.859, 2.341)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(userLocation, span)
            
            mapView.setRegion(region, animated: true)
            regionHasBeenCentered = true
        }
        
        self.mapView.showsUserLocation = true
        
//        test avec un pin
//        let loc = CLLocationCoordinate2DMake(37.780, -122.406)
//        let pin = PinAnnotation(title: "test", subtitle: "TEST", coordinate: loc)
//        self.mapView.addAnnotation(pin)
        
        //pin.userDistance = userDistance(lat: 37.780, lon: -122.406)
        
        self.mapView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setupMenuBar()
        sliderChanged(self)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        // for vacationer by default
        if swicther.isOn {
            parseKeeper()
        }
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
    
    
    // parse and add keeper's pin on map
    func parseKeeper() {
        // get data keepers from api
        createAnnotation(urlString: Constants.apiBaseUrl + "/watchmanlist?param=")
    }
    
    // // parse and add vacationer's pin on map
    func parseVacationer() {
        // get data vacationers from api
        createAnnotation(urlString: Constants.apiBaseUrl + "/vacancionerlist?param=")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //create annotation from url
    func createAnnotation(urlString: String) {
        // remove all annotations first
        if self.mapView.annotations.count != 0 {
            self.mapView.removeAnnotations(mapView.annotations)
        }
        
        let url = URL(string: urlString)
        
        let urlRequest = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            print(statusCode);
            if error != nil {
                print ("ERROR")
            }
            else {
                if let content = data {
                    do {
                        //Array
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(myJson)
                        
                        // parse json by getting users key
                        if let userPins = myJson as? [[String: AnyObject]] {
                            for userPin in userPins {
                                if let latitude = userPin["Geo_latitude"] as Any?, let longitude = userPin["Geo_longitude"] as Any?, let firstname = userPin["firstname"] as Any?, let note = userPin["note"] as Any?{
                                    let lat = latitude
                                    let lon = longitude
                                    let name = firstname
                                    let note = String(format: "%@", note as! CVarArg)
                                    
                                    print(lat)
                                    print(lon)
                                    print(name)
                                    print(note)
                                    // add annotation on map
                                    let loc = CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lon as! CLLocationDegrees)
                                    let pin = PinAnnotation(title: name as! String, subtitle: note, coordinate: loc, data: userPin as AnyObject)
                                    pin.userDistance = self.userDistance(lat: lat as! Double, lon: lon as! Double)
                                    self.mapView.addAnnotation(pin)
                                }
                            } // end loop parsing json data
                        }
                    } // end do
                    catch{}
                }
            } // end else
        }
        task.resume()
    }
    
    // custom annotation view
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        annotationView.image = UIImage(named: "pin")
        annotationView.canShowCallout = true
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        
        
        
        let pinAnnotation = annotation as! PinAnnotation
        
        //annotationView.detailCalloutAccessoryView = UIImageView(image: pinAnnotation.image)
        
        // Left Accessory
        let leftAccessory = UILabel(frame: CGRect(x: 0,y: 0,width: 50,height: 30))
        leftAccessory.text = pinAnnotation.userDistance
        leftAccessory.font = UIFont(name: "Verdana", size: 10)
        annotationView.leftCalloutAccessoryView = leftAccessory
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        self.selectedAnnotation = view.annotation as? PinAnnotation
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //let annview = view.annotation
        if control == view.rightCalloutAccessoryView {
            print(view.annotation?.title! as Any)
            let thisAnnot = view.annotation as! PinAnnotation
            idUser = String(format: "%@", thisAnnot.data!["id"] as! NSNumber)
            print(idUser)
            APIManager.sharedInstance.getUserProfile(_id: idUser, onSuccess: { json in
                if let string = json.rawString() {
                    print(string)
                }
                DispatchQueue.main.async(execute: {
                    self.selName = json["result"]["name"].stringValue;
                    self.selCity = json["result"]["city"].stringValue;
                    self.selEmail = json["result"]["email"].stringValue;
                    self.performSegue(withIdentifier: "userProfile", sender: self)
                })
            }, onFailure: { error in
                
            })
        }
    }
    
//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "moreDetail") {
//            // pass data to next view
//            let destViewController:PinProfileViewController = segue.destination as! PinProfileViewController
//            destViewController.viaSegue = (sender as! MKAnnotationView)
//        }
//    }
    
    // calcul user's distance to the specified point.
    private func userDistance(lat: Double, lon: Double) -> String? {
        guard let userLocation = mapView.userLocation.location else {
            return nil // User location unknown!
        }
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: lat, longitude:  lon)

        let pointLocation = CLLocation(
            latitude:  point.coordinate.latitude,
            longitude: point.coordinate.longitude
        )
        return "\(String(format: "%.0f", userLocation.distance(from: pointLocation))) m"
    }

    // change pin role on map
    @IBAction func switchChanged(_ sender: Any) {
        if (sender as AnyObject).isOn == true {
            switchRole.text = "Gardien"
            swicther.tag = 0
            parseKeeper()
        }
        else {
            switchRole.text = "Vacancier"
            swicther.tag = 1
            parseVacationer()
        }
    }
    
    // change zoom scale on map
    @IBAction func sliderChanged(_ sender: Any) {
        let miles = Double(self.slider.value)
        let km = miles / 1.6
        let delta = miles / 69.0
        
        var currentRegion = self.mapView.region
        currentRegion.span = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        self.mapView.region = currentRegion
        
        travelRadius.text = "\(Int(round(km))) Km"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "userProfile")
        {
            let vc = segue.destination as? PinProfileViewController
            vc?.nameStr = selName
            vc?.cityStr = selCity
            vc?.emailStr = selEmail
            vc?.numberStr = ""
        }
    }
}


//
//  MapViewController.swift
//  MeBoo
//
//  Created by Nam Phong Nguyen on 8/25/15.
//  Copyright (c) 2015 Nam Phong. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapview: MKMapView!
    var locationManager: CLLocationManager!
    var clinics: [Clinic]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.mapview.showsPointsOfInterest = true
        self.mapview.showsBuildings = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.checkLocationAuthorizationStatus()
        self.showClinicsToMap()
    }
    
    func showClinicsToMap() {
        for clinic in self.clinics {
            
            let cood = CLLocationCoordinate2D(latitude: CLLocationDegrees(clinic.latitude.doubleValue), longitude: CLLocationDegrees(clinic.longitude.doubleValue))
            let pin = SSLMapPin(coordinate: cood)
            pin.subtitle = clinic.contactNumber
            pin.title = clinic.name
            self.mapview.addAnnotation(pin)
        }
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            self.mapview.showsUserLocation = true
            var region = MKCoordinateRegionMakeWithDistance(self.mapview.userLocation.coordinate, 800, 800)
//            self.mapview.regionThatFits(region)
            self.mapview.region = region
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }

    }

    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800)
        mapView.region = region
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
//        if annotation.isKindOfClass(MKUserLocation) {
//            return nil
//        }
//        let AnnotationIdentifier = "AnnotationIdentifier"
//        var annoationView = mapView.dequeueReusableAnnotationViewWithIdentifier(AnnotationIdentifier) as MKAnnotationView!
//        if annoationView == nil {
//            annoationView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier)
//            
//            var imageView = UIImageView()
//            //        imageView.image = UIImage(named: "default_avatar")
//            imageView.layer.borderWidth = 1;
//            imageView.layer.borderColor = UIColor.whiteColor().CGColor
//            imageView.backgroundColor = UIColor.redColor()
//            var f: CGRect = CGRectMake(5,5.5,45,45);
//            imageView.frame = f
//            imageView.layer.cornerRadius = 22.5;
//            imageView.layer.masksToBounds = true;
//            annoationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
//            
//            annoationView.addSubview(imageView)
//            annoationView.enabled = true;
//            annoationView.canShowCallout = true;
//            annoationView.image = UIImage(named: "pin")
//            annoationView.draggable = false
//        }
        

//        
        let AnnotationIdentifier = "AnnotationIdentifier"
        
        var theAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: AnnotationIdentifier)
        
        var imageView = UIImageView()
//        imageView.image = UIImage(named: "default_avatar")
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.backgroundColor = UIColor.redColor()
        var f: CGRect = CGRectMake(5,5.5,45,45);
        imageView.frame = f
        imageView.layer.cornerRadius = 22.5;
        imageView.layer.masksToBounds = true;
        theAnnotationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIView
        
        theAnnotationView.addSubview(imageView)
        theAnnotationView.enabled = true;
        theAnnotationView.canShowCallout = true;
        theAnnotationView.image = UIImage(named: "pin")
        theAnnotationView.draggable = false
        return theAnnotationView
    }

}

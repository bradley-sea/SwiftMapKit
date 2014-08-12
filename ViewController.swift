//
//  ViewController.swift
//  mapdemo
//
//  Created by Bradley Johnson on 8/10/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var map : MKMapView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
       
    
        var monitoringavail = CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion)
        if monitoringavail == true {
            println("monitoring available")
        }
        else {
            println("monitoring not available")
        }

        self.map = MKMapView(frame: self.view.frame)
        self.view.addSubview(self.map)
        self.map.delegate = self
        
        let longpress = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        self.map.addGestureRecognizer(longpress)
        self.map.showsUserLocation = true

        
    var status = UIApplication.sharedApplication().backgroundRefreshStatus as UIBackgroundRefreshStatus
        
        println(status.toRaw())
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        var locationStatus = CLLocationManager.authorizationStatus() as CLAuthorizationStatus
        switch locationStatus {
        case .Authorized:
            println("authorized")
        default:
            println("default")
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized:
            //self.map.showsUserLocation = true
            println("authorized")
        default :
            println("uh oh")
        }
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        //should be dequeing here, and only create a new one if you dont get a dequeued one.
        var annotV = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MyCustomAnnotation")
       
        annotV.image = UIImage(named: "pin")
        annotV.animatesDrop = true
        annotV.canShowCallout = true
        var rightButton = UIButton.buttonWithType(UIButtonType.ContactAdd) as UIButton
        annotV.rightCalloutAccessoryView = rightButton
        return annotV
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        let reminderVC = self.storyboard.instantiateViewControllerWithIdentifier("ReminderVC") as ReminderViewController
        reminderVC.annotation = view.annotation
        reminderVC.locationManager = self.locationManager
        self.navigationController.pushViewController(reminderVC, animated: true)
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        self.performSegueWithIdentifier("yay", sender: self)
    }
    
    func handleLongPress(sender : AnyObject) {
        
        if let longPress = sender as? UILongPressGestureRecognizer {
            switch longPress.state {
            case .Began:
                println("began")
                var touchPoint = longPress.locationInView(self.map)
                var touchCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
                println("\(touchCoordinate.latitude), \(touchCoordinate.longitude) ")
                var annot = MKPointAnnotation()
                annot.coordinate = touchCoordinate
                annot.title = "Add New"
                self.map.addAnnotation(annot)
            default:
                return
            }
        }
    }
}


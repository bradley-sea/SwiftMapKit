//
//  ReminderViewController.swift
//  mapdemo
//
//  Created by Bradley Johnson on 8/11/14.
//  Copyright (c) 2014 learnswift. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ReminderViewController: UIViewController{
    
    var locationManager : CLLocationManager?
    var annotation : MKAnnotation?
    var names : [String]!

    @IBOutlet weak var longLabel: UITextField!
    @IBOutlet weak var latLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var regionSet = self.locationManager?.monitoredRegions
        var regions = regionSet!.allObjects
        
        for region in regions {
            if let circularRegion = region as? CLCircularRegion {
                
                println("\(circularRegion.identifier)")            }
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func confirmReminder(sender: AnyObject) {
        
        var geoRegion = CLCircularRegion(center: annotation!.coordinate, radius: 100.0, identifier: "Kigo")
        self.locationManager?.startMonitoringForRegion(geoRegion)
        var regionSet = self.locationManager?.monitoredRegions
        var regions = regionSet!.allObjects
        
        for region in regions {
            if let circularRegion = region as? CLCircularRegion {
                
                println("\(circularRegion.identifier)")            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        self.longLabel.text = "\(self.annotation!.coordinate.longitude)"
        self.latLabel.text = "\(self.annotation!.coordinate.latitude)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

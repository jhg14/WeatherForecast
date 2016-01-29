//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 28/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var coordButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Show user location at start.
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //maybe insert relevant map overlay
    // store of save locations
    
    func setMapLocation(latitude lat: Double, longitude long: Double) {
        var region = MKCoordinateRegion()
        region.center.latitude = lat
        region.center.longitude = long
        region.span.latitudeDelta = 0.12
        region.span.longitudeDelta = 0.12
        
        mapView.setRegion(region, animated: true)
    }
    
    func getMapLocation() -> MKCoordinateRegion {
        return mapView.region
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toCoords" {
            let dest = segue.destinationViewController as! CoordViewController
            dest.mapControl = self
            dest.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        }
    }
    
    @IBAction func coordButtonDown(sender: AnyObject) {
        self.performSegueWithIdentifier("toCoords", sender: sender)
    }
    
    
    @IBAction func forecastButtonDown(sender: AnyObject) {
        performSegueWithIdentifier("toForecast", sender: sender)
        
    }
    
    
    
    
    
    
    

}


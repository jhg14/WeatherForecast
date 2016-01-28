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
    var coordViewController: UIViewController?
    
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
    
    func setMapLocation() {
        mapView.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let dest = segue.destinationViewController
        
        dest.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        
        
    }
    
    @IBAction func coordButtonDown(sender: AnyObject) {
        self.performSegueWithIdentifier("toCoords", sender: sender)
    }

}


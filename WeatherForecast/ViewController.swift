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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.view.backgroundColor = UIColor.clearColor()
        self.modalPresentationStyle = UIModalPresentationStyle.CurrentContext
        presentingViewController?.presentViewController(self, animated: true, completion: nil)
    }
    
    @IBAction func swipeFromBottomGestureRecognised(sender: AnyObject) {
            performSegueWithIdentifier("toCoordEntry", sender: sender)
    }

}


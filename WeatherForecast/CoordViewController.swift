//
//  CoordViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 28/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit

class CoordViewController: UIViewController  {
    
    @IBOutlet weak var latitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    
    var mapControl: ViewController?
    
    
    @IBOutlet weak var longPlusMinus: UISegmentedControl!
    @IBOutlet weak var latPlusMinus: UISegmentedControl!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func panSwipeDown(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translationInView(self.view)
        if (translation.y > 0){
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    @IBAction func toCoordsDown(sender: AnyObject) {
        
        
        // Show specified location on map
        var lat: Double = ((latitudeField.text)! as NSString).doubleValue
        var long: Double = ((longitudeField.text)! as NSString).doubleValue
        
        if latPlusMinus.titleForSegmentAtIndex(latPlusMinus.selectedSegmentIndex) == "-" {
            lat = -lat
        }
        
        if longPlusMinus.titleForSegmentAtIndex(longPlusMinus.selectedSegmentIndex) == "-" {
            long = -long
        }
        
        mapControl?.setMapLocation(latitude: lat, longitude: long)
        dismissViewControllerAnimated(true, completion: nil)
        
        
        
        
    }
    
    
}

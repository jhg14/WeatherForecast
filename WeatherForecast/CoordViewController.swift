//
//  CoordViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 28/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit

class CoordViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func panSwipeDown(sender: UIPanGestureRecognizer) {
        
        var translation = sender.translationInView(self.view)
        if (translation.y > 0){
            dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    
    
}

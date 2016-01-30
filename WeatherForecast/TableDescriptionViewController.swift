//
//  TableDescriptionViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 30/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit

class TableDescriptionViewController: UIViewController {
    
    @IBOutlet var textArea: UITextView!
    
    var info: (LocationInfo, WeatherData)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.text = "\(info!.0.name) in \(info!.0.country)\n The weather: \(info!.1.weather.mainDescription): \(info!.1.weather.description)"
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

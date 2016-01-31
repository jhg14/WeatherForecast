//
//  TableDescriptionViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 30/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit
import Social

class TableDescriptionViewController: UIViewController {
    
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var titleText: UITextView!

    var info: (LocationInfo, WeatherData)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArea.text = "\(info!.0.name) in \(info!.0.country)\n The weather: \(info!.1.weather.mainDescription): \(info!.1.weather.description)\n Humidity: \(info!.1.humidity)\n Pressure: \(info!.1.pressure)\n Windspeed?: \(info!.1.speed)\nTemperature Throughout the day: \n\(tempForEachTime(info!.1.temp))"
        
        titleText.text = "\(info!.0.name) - \(info!.0.country)"
        
        
    }
    
    private func tempForEachTime(temps: [TempName: Float]) -> String {
        var str = ""
        
        for temp in temps {
            str += "\(temp.0): \(temp.1)\n"
        }
        return str
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func twitterButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Check out the temperature in \(info!.0.name) - \(info!.0.country)!")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func facebookButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook){
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
}

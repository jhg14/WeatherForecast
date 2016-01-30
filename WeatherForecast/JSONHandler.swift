//
//  JSONHandler.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 30/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import Foundation

class JSONHandler {

    let api_key = "92b07eb9d13717ffb9ddbed3d738ec73"
    
    var jsonData: NSData?
    
    
    func setUpRequest(){
        let requestLink = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID=\(api_key)")
        jsonData = NSData(contentsOfURL: requestLink!)
        
        if jsonData == nil {
            print("It's a nil ting on a dunkno bass")
        } else {
            print("It's a bun ting on a dunkno bass")
        }
        
    }
    
    
    func parseJSON(){
        
        do {
        
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                
                if let cities = json["city"] as? NSDictionary {
                
                    for city in cities {
                        print("found a city! \(city.key)")
                    }
                
                }
                
                
                
            }
            
        } catch {
            print("There was an error with NSJSONSerialization.")
        }
            
            
    }
    

}

//
//  JSONHandler.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 30/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import Foundation
import MapKit

struct WeatherData {

    let unixTime: Int
    let temp: [TempName: Float]
    let pressure: Float
    let humidity : Float
    let weather: Weather
    let speed: Float
    let deg: Int
    let clouds: Int
    let rain: Float?

}

struct Weather {

    let id: Int
    let mainDescription: String
    let description: String
    

}

enum TempName {

    case Day
    case Min
    case Max
    case Night
    case Eve
    case Morn


}

struct FullData {
    let locationInfo: LocationInfo
    let weatherForDays: [WeatherData]
}

struct LocationInfo {
    let id: Int
    let country: String
    let name: String
    let population: Int
}


class JSONHandler {

    let api_key = "92b07eb9d13717ffb9ddbed3d738ec73"
    
    
    var jsonData: NSData?
    
    
    func setUpRequest(coords: MKCoordinateRegion, count: Int){
        
        // remember the http:// 
        let requestLink = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?lat=\(coords.center.latitude)&lon=\(coords.center.longitude)&cnt=\(count)&APPID=\(api_key)")
        
        print(requestLink)
        
        jsonData = NSData(contentsOfURL: requestLink!)
        
        
    }
    
    
    func parseJSON() -> FullData {
        
        var weatherForDays = [WeatherData]()
        var locationInfo: LocationInfo!
        
        do {
        
            if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                
                if let area = json["city"] as? NSDictionary {
                    
                    let id: Int = area["id"] as! Int
                    let country: String = area["country"] as! String
                    let name: String = area["name"] as! String
                    let population: Int = area["population"] as! Int
                    
                    locationInfo = LocationInfo(id: id, country: country, name: name, population: population)
                    
                    
                }
                
                if let weatherEntries = json["list"] as? NSArray {
                
                    for day in weatherEntries {
                        
                        let dayDatum = day as! NSDictionary
                        
                        var temp = [TempName: Float]()
                        
                        if let temps = dayDatum["temp"] as? NSDictionary {
                            
                            temp[TempName.Day] = temps["day"] as? Float
                            temp[TempName.Eve] = temps["eve"] as? Float
                            temp[TempName.Max] = temps["max"] as? Float
                            temp[TempName.Min] = temps["min"] as? Float
                            temp[TempName.Morn] = temps["morn"] as? Float
                            temp[TempName.Night] = temps["night"] as? Float
                        
                        }
                        
                        var weather: Weather!
                        // will be initialised in the following
                        
                        if let weathers = dayDatum["weather"] as? NSArray {
                            
                            // Should only be 1
                            for weth in weathers {
                                
                                let wethDat = weth as! NSDictionary
                                
                                let id = wethDat["id"] as! Int
                                let mainDescription = wethDat["main"] as! String
                                let description = wethDat["description"] as! String
                                
                                weather = Weather(id: id, mainDescription: mainDescription, description: description)
                                
                            
                            }
                            
                        
                        }
                        
                        let unixTime: Int = dayDatum["dt"] as! Int
                        let pressure: Float = dayDatum["pressure"] as! Float
                        let humidity : Float = dayDatum["humidity"] as! Float
                        let speed: Float = dayDatum["speed"] as! Float
                        let deg: Int = dayDatum["deg"] as! Int
                        let clouds: Int = dayDatum["clouds"] as! Int
                        let rain: Float? = dayDatum["Rain"] as? Float
                        
                        let dayData = WeatherData(unixTime: unixTime, temp: temp, pressure: pressure, humidity: humidity, weather: weather, speed: speed, deg: deg, clouds: clouds, rain: rain)
                        
                        weatherForDays.append(dayData)
                        
                    }
                
                }
                
            }
            
        } catch {
            print("There was an error with NSJSONSerialization.")
        }
        
        return FullData(locationInfo: locationInfo, weatherForDays: weatherForDays)
            
            
    }
    

}

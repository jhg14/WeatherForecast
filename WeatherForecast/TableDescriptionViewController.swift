//
//  TableDescriptionViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 30/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit
import Social

class TableDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var tableTitles = ["Weather: ", "Humidity: ", "Pressure: ", "Windspeed: ", "Morning Temp: ", "Day Temp: ", "Evening Temp: ", "Night Temp: ", "Maximum Temp: ", "Minimum Temp: "]
    

    var info: (LocationInfo, WeatherData)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(info!.0.name) - \(info!.0.country)"
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prototype1", forIndexPath: indexPath)
        
        
        let detail: String = getOrderedTableData()[indexPath.row]
        
        cell.textLabel?.text = "\(tableTitles[indexPath.row])\(detail)"
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableTitles.count
        
    }
    
    

    func getOrderedTableData() -> [String] {
        var strArr: [String] = []
        
        strArr.append("\(info!.1.weather.mainDescription) - \(info!.1.weather.description)")
        strArr.append("\(info!.1.humidity)")
        strArr.append("\(info!.1.pressure)")
        strArr.append("\(info!.1.speed)")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Morn]!))")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Day]!))")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Eve]!))")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Night]!))")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Max]!))")
        strArr.append("\(fromKelvin(info!.1.temp[TempName.Min]!))")
        
        return strArr
    }
    
    private func fromKelvin(x: Float) -> Float {
        let i = Float(round(100*(x-273.15))/100)
        return i
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonPushed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func twitterButtonPushed(sender: UIButton) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Check out the weather in \(info!.0.name) - \(info!.0.country)!\n\n \(truncData())")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func tableAsString() -> String {
        var str = ""
        
        var tabDat = getOrderedTableData()
        
        for i in 0...tableTitles.count-1 {
            str.appendContentsOf("\(tableTitles[i])\(tabDat[i])\n")
        }
    
        return str
    }
    
    
    func truncData() -> String {
     
        return "\(info!.1.weather.mainDescription) : \(info!.1.weather.description)\n Temperature: \(info!.1.temp[TempName.Day]!)"
        
    }
    
    
}

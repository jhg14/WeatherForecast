//
//  WeatherTableViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 29/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit

struct CellData {
    let date: NSDate
    let weatherDesc: String
    let tempOnlyDay: Float
}


class WeatherTableViewContoller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: FullData?
    
    @IBOutlet weak var titleAsButton: UIButton!
    
    var lastDataClicked: (LocationInfo, WeatherData)?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        titleAsButton.setTitle(data?.locationInfo.name, forState: .Normal)
        
        
        
    }
    
    private func fromKelvin(x: Float) -> Float {
        let i = Float(round(100*(x-273.15))/100)
        return i
        
    }
    
    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return data?.locationInfo.name
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellData = getCellData(indexPath.row)
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("weathercell", forIndexPath: indexPath) as UITableViewCell
        
        var str = cellData.date.description as NSString
        str = str.substringToIndex(10)
        cell.textLabel?.text = str as String
        cell.detailTextLabel?.text = "Weather: \(cellData.weatherDesc), Day Temp: \(fromKelvin(cellData.tempOnlyDay))"
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let i = data?.weatherForDays.count {
            return i
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dataToPass: (LocationInfo, WeatherData) = ((data?.locationInfo)!, (data?.weatherForDays[indexPath.row])!)
        
        lastDataClicked = dataToPass
        
        performSegueWithIdentifier("toDescription", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toDescription" {
            let dest = segue.destinationViewController as! TableDescriptionViewController
            dest.info = lastDataClicked
        }
        
    }
    
    
    @IBAction func dismissButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    private func convertDateFromUnix(dateInUnix: Int) -> NSDate {
        return NSDate(timeIntervalSince1970: NSTimeInterval(dateInUnix))
    }

    
    private func getCellData(dayOfTen: Int) -> CellData {
    
        //shouldnt be any cells if no data therefore can assert not nil with !
        let date = convertDateFromUnix((data?.weatherForDays[dayOfTen].unixTime)!)
        let weatherDesc = data?.weatherForDays[dayOfTen].weather.mainDescription
        let tempOnlyDay = data?.weatherForDays[dayOfTen].temp[TempName.Day]
        
        let cellData = CellData(date: date, weatherDesc: weatherDesc!, tempOnlyDay: tempOnlyDay!)
        
        return cellData
    
    }
    
    
    
}

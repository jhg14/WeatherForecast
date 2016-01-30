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
    
    var lastDataClicked: (LocationInfo, WeatherData)?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data?.locationInfo.name
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellData = getCellData(indexPath.row)
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("weathercell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = cellData.date.description
        cell.detailTextLabel?.text = "Weather: \(cellData.weatherDesc) *** Day Temp: \(cellData.tempOnlyDay)"
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
    
    
    @IBAction func swipeToGoBack(sender: AnyObject) {
        //if swipe direction right && in bottom portion, go back
        
        let acceptableY = self.view.frame.height - 44
        
        let gesture = sender as! UISwipeGestureRecognizer
        
        if (gesture.direction == UISwipeGestureRecognizerDirection.Right) &&
            (gesture.locationInView(self.view).y > acceptableY){
        
                dismissViewControllerAnimated(true, completion: nil)
        
        }
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

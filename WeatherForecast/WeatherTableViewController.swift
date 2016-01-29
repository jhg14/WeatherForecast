//
//  WeatherTableViewController.swift
//  WeatherForecast
//
//  Created by Jonny Goff-White on 29/01/2016.
//  Copyright © 2016 Jonny Goff-White. All rights reserved.
//

import UIKit

class WeatherTableViewContoller: UIViewController, UITableViewDataSource {
    
    var tableData: [String] = ["Paris", "London", "Tokyo", "Los Angeles", "New York"]
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("weathercell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
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
    
    
    
    
}

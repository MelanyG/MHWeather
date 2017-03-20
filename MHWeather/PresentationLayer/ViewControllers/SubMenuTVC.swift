//
//  SubMenuTVC.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class SubMenuTVC: UITableViewController {
    
weak var delegate: LocationSelectionDelegate?
//var locationPoints = [LocationCellObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        locationPoints.append(LocationCellObject(img: "controls-share", text: "Share", updLatitude: "", updLongitude: ""))
//        locationPoints.append(LocationCellObject(img: "selectedPin", text: "EditLocations", updLatitude: "", updLongitude: ""))
//        locationPoints.append(LocationCellObject(img: "pin", text: "New York", updLatitude: "40.730610", updLongitude: "-73.935242"))
//        locationPoints.append(LocationCellObject(img: "pin", text: "Paris", updLatitude: "48.864716", updLongitude: "2.349014"))
//        locationPoints.append(LocationCellObject(img: "pin", text: "Chicago", updLatitude: "41.881832", updLongitude: "-87.623177"))
//        locationPoints.append(LocationCellObject(img: "pin", text: "Lviv", updLatitude: "49.8397", updLongitude: "24.0297"))
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataSource.sharedDataSource.locationPoints.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as? BaseTableViewCell
        cell?.imgView.image = DataSource.sharedDataSource.locationPoints[indexPath.row]?.getImage()
        
        cell?.lbl.text = DataSource.sharedDataSource.locationPoints[indexPath.row]?.textLbl
         //Configure the cell...

        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedlocation = DataSource.sharedDataSource.locationPoints[indexPath.row]
        guard let newLoc = selectedlocation else { return }
        self.delegate?.locationSelected(newLocation: newLoc, selectedIndex:indexPath.row)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

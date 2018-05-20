//
//  Status_report_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/18/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class Status_report_TableViewController: UITableViewController {
    
    
    
    @IBAction func refresh_action(_ sender: Any) {
        
        print("########################************************************************")
       
        print(report_orders.count)
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() { super.viewDidLoad()
        
       
      
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        print("########################************************************************")
        print(report_orders.count)
//        print(report_orders[0].Status)
      
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return report_orders.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
         cell.textLabel?.text = "\(report_orders[indexPath.row].Status) \n \(report_orders[indexPath.row].TotalPrepTime) \n \(report_orders[indexPath.row].OrderID) \n \(report_orders[indexPath.row].createdAt) \n \(report_orders[indexPath.row].PickupTime) \n \n \(report_orders[indexPath.row].Items[0].Name)"
        
        
        

        return cell
    }
   

}

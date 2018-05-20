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
        
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
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
    
    @objc func buttonClicked(sender:UIButton)
    {
        var msg = "select how you want to sort!!! "
        let alert = UIAlertController(title: msg, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Order time", style: .default, handler: { action in self.sort_order_time() } ))
        alert.addAction(UIAlertAction(title: "Fulfillment start-time", style: .default, handler: { action in self.sort_fulfilment_time() } ))
        self.present(alert, animated: true)
        
    }
    
    func sort_order_time(){
        
        
        
    }
    
    func sort_fulfilment_time(){
        
    }
    
  
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let frame = tableView.frame
        let rect = CGRect(x: 300, y: 30, width: 300, height: 40)
        let headerView = UIView(frame: rect)
        headerView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let rect1 = CGRect(x: 0, y: 0, width: 300, height: 30)
        let label = UILabel(frame: rect1)
        label.text = "Status Report"
        //vw.backgroundColor = UIColor.red
        label.font = label.font.withSize(25)
        label.textColor = UIColor.black
        let rect2 = CGRect(x: 200, y: 0, width: 300, height: 30)
        let button = UIButton(frame: rect2)
        button.tag = section
        var image:UIImage!
        button.setImage(UIImage(named: "connect-arrow-up-down-7.png"), for: UIControlState.normal)
        button.tag = section;
        button.addTarget(self,action:#selector(buttonClicked),for:.touchUpInside)
        headerView.addSubview(label)
        headerView.addSubview(button)
        
        return headerView
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
         cell.textLabel?.text = "\(report_orders[indexPath.row].Status) \n \(report_orders[indexPath.row].TotalPrepTime) \n \(report_orders[indexPath.row].OrderID) \n \(report_orders[indexPath.row].createdAt) \n \(report_orders[indexPath.row].PickupTime) \n \n \(report_orders[indexPath.row].Items[0].Name)"
        
        
        /// count of Items ..

        return cell
    }
   

}

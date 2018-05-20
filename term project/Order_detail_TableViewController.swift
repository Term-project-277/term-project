//
//  Order_detail_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/19/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

var selected_order_id = 0
var selected_menu_id = 0
var selected_menu_name = ""
var cnt:Int = 0



class Order_detail_TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        cnt = 0
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        cnt = 0
        return orders[selected_row].Items.count
        //return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let orderDetails = NSMutableAttributedString(string:"")
        cell.textLabel?.numberOfLines = 0
        
        
//
//        var rrs = ""
//        if orders[selected_row].Items[cnt].Rating == nil
//        {
//            rrs = "This item is not rated yet"
//        }
//        else
//        {
//            rrs = "\( orders[selected_row].Items[cnt].Rating) ⭐️s"
//        }
//
        
        
        
        
        //let itemCount = orders[selected_row].Items.count
        //for i in 0...itemCount-1
        //{
            let length = orders[selected_row].Items[cnt].Name.count
            let itemDetails = NSMutableAttributedString(string: "\nItem Name:\t\t\t\(orders[selected_row].Items[cnt].Name)\nQuantity\t\t\t\t\(orders[selected_row].Items[cnt].Quantity)\nMenu ID:\t\t\t\t\(orders[selected_row].Items[cnt].MenuID)\nPreparation Time:\t\t \(orders[selected_row].Items[cnt].Preparationtime)\n ")
            orderDetails.append(itemDetails)
            var attributes = [NSAttributedStringKey: AnyObject]()
            attributes[.foregroundColor] = UIColor.blue
            attributes[.font] = UIFont.boldSystemFont(ofSize: 16) as AnyObject
        let rateMessage = NSMutableAttributedString(string: "Click here to rate \(orders[selected_row].Items[cnt].Name)",attributes:attributes)
            orderDetails.append(rateMessage)
        //}
        cell.textLabel?.attributedText = orderDetails
        // Configure the cell...
        cnt += 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       selected_order_id = orders[selected_row].OrderID
        selected_menu_id = orders[selected_row].Items[indexPath.row].MenuID
        selected_menu_name =   orders[selected_row].Items[indexPath.row].Name
        user_email =    "\(orders[selected_row].User)"
        
        performSegue(withIdentifier:"rate_item" , sender: self)
    }
   


}

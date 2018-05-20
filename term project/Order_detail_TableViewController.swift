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
        //let itemCount = orders[selected_row].Items.count
        //for i in 0...itemCount-1
        //{
            let length = orders[selected_row].Items[cnt].Name.count
            let itemDetails = NSMutableAttributedString(string: "\nItem Name:\t\t\t\(orders[selected_row].Items[cnt].Name)\nQuantity\t\t\t\t\(orders[selected_row].Items[cnt].Quantity)\nMenu ID:\t\t\t\t\(orders[selected_row].Items[cnt].MenuID)\nPreparation Time:\t\t \(orders[selected_row].Items[cnt].Preparationtime)\n")
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
        user_email =    "\(orders[selected_row].User)"
        
        performSegue(withIdentifier:"rate_item" , sender: self)
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

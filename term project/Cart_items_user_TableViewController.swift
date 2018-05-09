//
//  Cart_items_user_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/7/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

struct item : Decodable {
    let Name : String
    let Quantity : Int
    let Unitprice : Double
}

var items = [item] ()




class Cart_items_user_TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadcart()
    }
    
    func loadcart()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/cart/shwetha@gmail.com"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                items = try JSONDecoder().decode([item].self, from: data!)
                
                print(" got all items")
                
                self.tableView.reloadData()
            }
            catch{
                
                print("printitng error here##############")
                print(err)
            }
            
            }.resume()
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//         Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        cell.textLabel?.numberOfLines = 2
        
        //Unitprice
        var text = "\(items[indexPath.row].Name)"
        var count =  text.count
        var diff = 20 - count
        if(diff > 0){
        for index in 1...diff
        {
            text += "  "
            }
        }
        
        cell.textLabel?.text = "\(text)\(items[indexPath.row].Quantity)\t\t\t\t\(items[indexPath.row].Unitprice)"

       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = "Name\t\t\t  Quantity\t  Price"
        label.font = label.font.withSize(28)
        label.textColor = UIColor.white
        label.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
     
        
        return label
        
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

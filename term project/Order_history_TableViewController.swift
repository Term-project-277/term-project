//
//  Order_history_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/14/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit


extension DateFormatter {
    func date(fromSwapiString dateString: String) -> Date? {
        // SWAPI dates look like: "2014-12-10T16:44:31.486000Z"
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.date(from: dateString)
    }
}

struct order : Decodable {
        let TotalPrepTime : Int
        let User : String
        let Status : String
        let OrderID : Int
        let FulfillmentStartTime : String
        let ReadyTime : String
        let PickupTime: String
        let Items : [order_item]
    }

    var orders = [order] ()


struct order_item : Decodable {
    let Preparationtime : Int
    let MenuID : Int
    let Name : String
    let Quantity : Int
    
}
var order_items = [order_item] ()


class Order_history_TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
                tableView.rowHeight = UITableViewAutomaticDimension
        
                loadorders()
            }
    
            func loadorders()
            {
                let jsonurl = "https://mobile-ios-backend.herokuapp.com/order/\(user_email)"
                let url = URL(string: jsonurl )
        
                print(url )
        
                URLSession.shared.dataTask(with: url!) { (data, resp, err) in
        
                    do {
        
                        let myGroup = DispatchGroup()
                        myGroup.enter()
                        
                        let decoder =  JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601

                        orders = try decoder.decode([order].self, from: data!)
        
                        myGroup.leave()
        
                        myGroup.notify(queue: DispatchQueue.main) {
                            self.tableView.reloadData()
                        }
        
                    }
                    catch{
        
                        print("printitng error here##############")
                        print(err)
                    }
        
                    }.resume()
            }
    

   
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        //          let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
        //        label.bounds = rect
        //label.text = "ID\t  Status \t  Ready time"
        label.text = "Order History"
        label.font = label.font.withSize(25)
        label.textColor = UIColor.black
        label.backgroundColor =  #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        
        
        return label
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dateFormatter1 = DateFormatter()
        let createdDate = dateFormatter1.date(fromSwapiString: orders[indexPath.row].ReadyTime)
        
        let dateFormatter2 = DateFormatter()
        // short format like "12/9/14, 9:50 AM"
        dateFormatter2.dateStyle = .medium
        dateFormatter2.timeStyle = .short
        
        let readytime = dateFormatter2.string(from: createdDate! )
        print(readytime)
        
        let createdDate1 = dateFormatter1.date(fromSwapiString: orders[indexPath.row].FulfillmentStartTime)
        let fullfilmentstarttime = dateFormatter2.string(from: createdDate1! )
        
        let createdDate2 = dateFormatter1.date(fromSwapiString: orders[indexPath.row].PickupTime)
        let pickuptime = dateFormatter2.string(from: createdDate2! )
        

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        
        
        
        cell.textLabel?.numberOfLines = 0
//
        var attributes = [NSAttributedStringKey: AnyObject]()
       
        attributes[.font] = UIFont.systemFont(ofSize: 15) as AnyObject


        let attributedString = NSMutableAttributedString(string: "Order ID:\t\t\t\(orders[indexPath.row].OrderID)\nOrder Status:\t\t\(orders[indexPath.row].Status)\nReady Time:\t\t\(readytime)", attributes:attributes)
        
        let normalString = NSMutableAttributedString(string: "\nPickup Time:\t\t\( pickuptime )\nFulfillment Time:\t\(fullfilmentstarttime)\n", attributes:attributes)
        attributedString.append(normalString)
        var attribut = [NSAttributedStringKey: AnyObject]()
        attribut[.foregroundColor] = UIColor.blue
        attribut[.font] = UIFont.boldSystemFont(ofSize: 15) as AnyObject
        let message = NSMutableAttributedString(string: "\nClick here to view the details of order \((orders[indexPath.row].OrderID))\n",attributes:attribut)
        attributedString.append(message)
        cell.textLabel?.attributedText = attributedString
        return cell
    }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
        
    
        
        
        
                }
            }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_section =  indexPath.section
        selected_row =  indexPath.row
        
        performSegue(withIdentifier:"order_detail" , sender: self)
    }
    
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .default, title: "Cancel") { (action, indexPath) in
            // here implement your delete code
        
            let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/order/cancel/\(orders[indexPath.row].OrderID)"
            
            var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
            firstTodoUrlRequest.httpMethod = "PUT"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: firstTodoUrlRequest) {
                (data, response, error) in
                guard let _ = data else {
                    print("error calling cancel on ")
                    return
                }
                print("cancel ok")
                
                self.loadorders()
            }
            task.resume()
        
        }
        
       
        return [deleteButton]
    }

}




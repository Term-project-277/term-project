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
        let Status : String
        let OrderID : Int
        let FulfillmentStartTime : String
        let ReadyTime : String
    let PickupTime: String
    }

    var orders = [order] ()

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
        label.text = "ID\t  Status \t  Ready time"
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


            let attributedString = NSMutableAttributedString(string: "\(orders[indexPath.row].OrderID) \t  \(orders[indexPath.row].Status)  \(readytime)", attributes:attributes)
        
        let normalString = NSMutableAttributedString(string: "\n\n Pickup Time: \( pickuptime )\n \n Fulfillment Start Time: \( fullfilmentstarttime )", attributes:attributes)
        
        
        attributedString.append(normalString)
        
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












////
//  Cart_items_user_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/7/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//
//
//import UIKit
//
//struct item : Decodable {
//    let ID : String
//    let Name : String
//    let Quantity : Int
//    let Unitprice : Double
//    let Preparationtime : Int
//}
//
//var items = [item] ()
//
//
//
//
//class Cart_items_user_TableViewController: UITableViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
//        tableView.rowHeight = UITableViewAutomaticDimension
//
//        loadcart()
//    }
//
//    func loadcart()
//    {
//        let jsonurl = "https://mobile-ios-backend.herokuapp.com/cart/\(user_email)"
//        let url = URL(string: jsonurl )
//
//        print(url )
//
//        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
//
//            do {
//
//                let myGroup = DispatchGroup()
//                myGroup.enter()
//                items = try JSONDecoder().decode([item].self, from: data!)
//
//                myGroup.leave()
//
//                myGroup.notify(queue: DispatchQueue.main) {
//                    self.tableView.reloadData()
//                }
//
//            }
//            catch{
//
//                print("printitng error here##############")
//                print(err)
//            }
//
//            }.resume()
//    }
//
//
//
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return items.count
//    }
//
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        //         Configure the cell...
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        cell.textLabel?.numberOfLines = 2
//
//        //Unitprice
//        var text = "\(items[indexPath.row].Name)"
//        var count =  text.count
//        var diff = 20 - count
//        if(diff > 0){
//            for index in 1...diff
//            {
//                text += "  "
//            }
//        }
//
//        cell.textLabel?.text = "\(text)\(items[indexPath.row].Quantity)\t\t\t\t\(items[indexPath.row].Unitprice)"
//
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let label = UILabel()
//        //          let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
//        //        label.bounds = rect
//        label.text = "Name\t\t\t  Quantity\t  Price"
//        label.font = label.font.withSize(25)
//        label.textColor = UIColor.black
//        label.backgroundColor =  #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
//
//
//        return label
//
//    }
//
//
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//
//
//            //             Delete the row from the data source
//
//            var s = String(items[indexPath.row].ID)
//            let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/cart/\(user_email)/" + s
//
//            var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
//            firstTodoUrlRequest.httpMethod = "DELETE"
//
//            let session = URLSession.shared
//
//            let task = session.dataTask(with: firstTodoUrlRequest) {
//                (data, response, error) in
//                guard let _ = data else {
//                    print("error calling DELETE on /todos/1")
//                    return
//                }
//                print("DELETE ok")
//
//                self.loadcart()
//            }
//            task.resume()
//
//
//
//        }
//    }
//
//
//
//}


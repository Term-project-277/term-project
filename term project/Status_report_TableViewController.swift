//
//  Status_report_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/18/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class Status_report_TableViewController: UITableViewController {
    
    
    
    
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
        
        DispatchQueue.main.async {
            self.load_sorted_order_time( "https://mobile-ios-backend.herokuapp.com/order/report/OrderTime") {
                DispatchQueue.main.async {
                  self.tableView.reloadData()
                }
            }
        }
            
   }
    
    
    
    
    func sort_fulfilment_time(){
        
        DispatchQueue.main.async {
            self.load_sorted_order_time( "https://mobile-ios-backend.herokuapp.com/order/report/FulfillmentTime") {
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
    
    
    
    func load_sorted_order_time(_ x: String, completion: @escaping ()->() ) {
        //    func load_status_report () {
        var parameters = [
            "fromDate": "",
            "toDate": "",
            ] as [String : Any]
        
        //        parameters["fromDate"] = "\(from_date.date)"
        parameters["fromDate"] = "01-01-2018"
        
        //        parameters["toDate"] = "\(to_date.date)"
        parameters["toDate"] = "05-30-2018"
        
        guard let url = URL(string: x) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        print(httpBody)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
                print(response)
            }
            
            if let data = data {
                do {   report_orders = try JSONDecoder().decode([report_order].self, from: data)
                    
                    print("*******************json*********************")
                    print(report_orders.count)
                    //                    print(report_orders[0].TotalPrepTime)
                    
                    completion()
                    
                }catch {
                    
                    print("###############################################")
                    print(error)
                }
                
            }
            }.resume()
        
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
        
        let dateFormatter1 = DateFormatter()
        let createdDate = dateFormatter1.date(fromSwapiString: "\(report_orders[indexPath.row].createdAt)")
        let dateFormatter2 = DateFormatter()
        // short format like "12/9/14, 9:50 AM"
        dateFormatter2.dateStyle = .medium
        dateFormatter2.timeStyle = .short
        let readyTime = dateFormatter2.string(from: createdDate! )
        
        let pickupDate = dateFormatter1.date(fromSwapiString: "\(report_orders[indexPath.row].PickupTime)")
        let dateFormatter3 = DateFormatter()
        // short format like "12/9/14, 9:50 AM"
        dateFormatter3.dateStyle = .medium
        dateFormatter3.timeStyle = .short
        let pickupTime = dateFormatter2.string(from: pickupDate! )
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        let orderDetails = NSMutableAttributedString(string: "Order Status:\t\t \(report_orders[indexPath.row].Status)\nOrder ID:\t\t\t \(report_orders[indexPath.row].OrderID)\nTotal Prep Time:\t\(report_orders[indexPath.row].TotalPrepTime)\nReady Time:\t\t\(readyTime)\nPickup Time:\t\t\(pickupTime)\n\n\nItem Details\t\t\t\t\tQuantity\n")
        let itemCount = report_orders[indexPath.row].Items.count
        for i in 0...itemCount-1
        {
            let length = report_orders[indexPath.row].Items[i].Name.count
            var spaces = ""
            var diff = 44-length
            for j in 1...diff
            {
                spaces += " "
            }
            let itemDetails = NSMutableAttributedString(string: "\(report_orders[indexPath.row].Items[i].Name)\(spaces)\(report_orders[indexPath.row].Items[i].Quantity)\n")
            orderDetails.append(itemDetails)
        }
        cell.textLabel?.attributedText = orderDetails
        //" \nItems: \n \(report_orders[indexPath.row].Items[0].Name)"
        
        /// count of Items ..

        return cell
    }
   

}

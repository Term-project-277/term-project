//
//  Fetch_status_report_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/18/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

var parameters = [
    "fromDate": "",
    "toDate": "",
    ] as [String : Any]

struct report_order : Decodable {
    let TotalPrepTime : Int
    let Status : String
    let User : String
    let FulfillmentStartTime : String
    let ReadyTime : String
    let PickupTime : String
    let createdAt : String
    let updatedAt :  String
    let OrderID : Int
    let Items : [report_item]
}
var report_orders = [report_order] ()


struct report_item : Decodable {
    let Preparationtime : Int
    let MenuID : Int
    let Name : String
    let Quantity : Int
}
var report_items = [report_item] ()

class Fetch_status_report_ViewController: UIViewController {

    
    
    @IBOutlet var from_date: UIDatePicker!
    
    @IBOutlet var to_date: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    @IBAction func from_date_Action(_ sender: Any) {
    }
    
    @IBAction func to_date_Action(_ sender: Any) {
        
        let currentDate = from_date.date
        let oneDay = 24 * 60 * 60
        let minDate = currentDate
        let maxDate = currentDate.addingTimeInterval(TimeInterval(6 * oneDay))
        to_date.minimumDate = minDate
        to_date.maximumDate = maxDate
    }
    
    
    @IBAction func submit_action(_ sender: Any) {
        
        
        
//        performSegue(withIdentifier: "status_report_segue", sender: self)
        
        
        DispatchQueue.main.async {
        self.load_status_report {

             self.performSegue(withIdentifier: "status_report_segue", sender: self)

            }
        }
        
        
//        let myGroup = DispatchGroup()
//        myGroup.enter()
//        load_status_report()
//
//        myGroup.leave()
//
//        myGroup.notify(queue: DispatchQueue.main) {
//             self.performSegue(withIdentifier: "status_report_segue", sender: self)
//        }
//
        
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "status_report_segue"  {
            // status_report_segue
            
//                    load_status_report()

            
         
        }     
    }
    

   
    func load_status_report(completion: @escaping ()->() ) {
//    func load_status_report () {
   
        
                parameters["fromDate"] = "\(from_date.date)"
//        parameters["fromDate"] = "01-01-2018"
        
              parameters["toDate"] = "\(to_date.date)"
//        parameters["toDate"] = "05-30-2018"
        
        guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/order/report") else { return }
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
   

    
    
}

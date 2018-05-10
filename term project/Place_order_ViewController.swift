//
//  Place_order_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/8/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class Place_order_ViewController: UIViewController {

    @IBOutlet var date_picker: UIDatePicker!
    
    @IBAction func date_picker(_ sender: Any) {

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func date(_ sender: Any) {
        
        
        date_picker.timeZone = TimeZone.init(secondsFromGMT: 0)
       
       print( date_picker.date )
        
    }
    @IBAction func datepicker_action(_ sender: Any) {
       
    }
    
    
    @IBAction func place_order_button(_ sender: Any) {
        
        struct response : Decodable {
            let Status : String
           
        }
        
        
        var parameters = [
            "User": "",
           "PickupTime": "",
           "Items" : []
            ] as [String : Any]
        
        
        parameters["PickupTime"] = " \(date_picker.date)"
        var items11 = [
            "Preparationtime" : 0
            ] as [String : Any]
        
        var items11s = [items11]
        
        parameters["User"] =  user_email
       // parameters["Items"] =  items
        // place order
        
    //    var i =0
        for i in 0...items.count-1{
             items11s[ i ]["Preparationtime"] = items[i].Preparationtime
            
        }
        
       parameters["Items"] = items11s
        
        
        print(parameters)
        
      //  print(items)
        
        guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/order/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody

        print(httpBody)

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }

            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
                        
                    if let foo = json!["Status"] as? String   {
                        
                        print("\n  \n printing foo here@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(foo)
                        
                        if foo == "PLACED"
                        {
                            
                            DispatchQueue.main.async {
                                let banner = NotificationBanner(title: "Placed order successfully! ", subtitle: "Pick up time at \( self.date_picker.date)!", style: .success)
                                banner.show()
                            }
                        }
                        
                        print("\n \n printing foo here@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        }
                    
                    
                    

                } catch {
                    print(error)
                }
            }
         }.resume()
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

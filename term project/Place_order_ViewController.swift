//
//  Place_order_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/8/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift



extension Date {
    static func getFormattedDate(string: String ) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+hh:mm"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy,HH:mm"
        
        let date: Date? = dateFormatterGet.date(from: string )
        print("Date",dateFormatterPrint.string(from: date!)) // Feb 01,2018
        return dateFormatterPrint.string(from: date!);
    }
}



class Place_order_ViewController: UIViewController {
    
    
    @IBOutlet var place_outlet: UIButton!
    func loadcart()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/cart/\(user_email)"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                let myGroup = DispatchGroup()
                myGroup.enter()
                items = try JSONDecoder().decode([item].self, from: data!)
                
                myGroup.leave()
                
                myGroup.notify(queue: DispatchQueue.main) {
                
                }
                
            }
            catch{
                
                print("printitng error here##############")
                print(err)
            }
            
            }.resume()
    }

    
    
   
    
    @IBOutlet var date_picker: UIDatePicker!
    
    @IBOutlet weak var time_picker: UIDatePicker!
    
    //var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if(items.count == 0 )
        {
                place_outlet.isEnabled = false
        }
        else{
            place_outlet.isEnabled = true
        }
        
        
    }
    
    

    @IBAction func date(_ sender: Any) {
//        date_picker.timeZone = TimeZone.init(secondsFromGMT: 0)
        let currentDate = Date()
        let oneDay = 24 * 60 * 60
        let minDate = currentDate.addingTimeInterval(TimeInterval(0 * oneDay))
        let maxDate = currentDate.addingTimeInterval(TimeInterval(7 * oneDay))
        date_picker.minimumDate = minDate
        date_picker.maximumDate = maxDate
    }
    
    
    
    @IBAction func datepicker_action(_ sender: Any) {
       
    }
    
    
    @IBAction func place_order_button(_ sender: Any) {
        
        struct response : Decodable {
            let Status : String
           
        }
        
        
        loadcart()
        // call loadcart here ..
        
        var parameters = [
            "User": "",
           "PickupTime": "",
           "Items" : []
            ] as [String : Any]
        
        
        
        if( items.count == 0 )
        {
            
            
            
        }
        
        else
        {
            
            parameters["PickupTime"] = " \(date_picker.date)"
            var items11 = [
                "Preparationtime" : items[0].Preparationtime,
                "Quantity" : items[0].Quantity,
                "MenuID" : items[0].ID,
                "Name" : items[0].Name
                ] as [String : Any]
            
            var items11s = [items11]
            
            
            parameters["User"] =  user_email
            // parameters["Items"] =  items
            // place order
            
            //    var i =0
            for i in 1..<items.count{
                
                items11s.append(["Preparationtime": items[i].Preparationtime , "Quantity": items[i].Quantity  , "MenuID": items[i].ID , "Name": items[i].Name ] )
                
                
                
            }
            
            parameters["Items"] = items11s
            
        }
        
        
        
        
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
                    
                    if let date_time = json!["PickupTime"] as? String   {
                        print("\n  \n printing date tiem  here@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(date_time)
                  
                        
                    if let foo = json!["Status"] as? String   {
                        
                        print("\n  \n printing foo here@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        print(foo)
                        
                        print(json)
                        
                        if foo == "PLACED"
                        {
                            
                            var ss11 = "\((self.date_picker.date))"
                            
                            
                            //\( Date.getFormattedDate(string: ss11 )
                            
                            DispatchQueue.main.async {
                                let banner = NotificationBanner(title: "Placed order successfully! ", subtitle: "Pick up time at:  \( self.date_picker.date ) )!", style: .success)
                                banner.show()
                            }
                            
                            self.place_outlet.isEnabled = false
                            
                        }
                        else if foo == "SLOT_NOT_AVAILABLE"
                        {
                            DispatchQueue.main.async {
                                
                                //Date.getFormattedDate(string: date_time
                                
                                let banner = NotificationBanner(title: "Slot is not available! ", subtitle: "latest available time is: \( date_time) )!", style: .danger)
                                banner.show()
                            }
                            
                        }
                        
                        print("\n \n printing foo here@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
                        }
                    
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

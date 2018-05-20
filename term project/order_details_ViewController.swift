//
//  order_details_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/15/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class order_details_ViewController: UIViewController {

    var no_of_stars  = 0
    
    
    @IBOutlet var star_buttons: [UIButton]!
    
    
    @IBAction func Rate_action(_ sender: Any) {
        
        //do post {
//        "Name":"Veg Biryani",
//        "rating":5,
//        "Quantity":1,
//        "Preparationtime":5
//    }
//        http://localhost:3000/order/rating/shwetaajit.kothari@sjsu.edu/279/2
        // useremail ,... seleced order id . selected menuid
        
        var parameters = [
            "Name": "",
            "rating": 0,
            "Quantity" : 0,
            "Preparationtime" : 0,
            ] as [String : Any]
        
        parameters["rating"] = no_of_stars
        
        
        
        
        guard let url = URL(string: "http://localhost:3000/order/rating/\(user_email)/\(selected_order_id)/\(selected_menu_id)") else { return }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                    DispatchQueue.main.async {
                        let banner = NotificationBanner(title: " Ratings submitted successfully! ", subtitle: "", style: .success)
                        banner.show()
                    }
                    
                    
                    
                } catch {
                    print(error)
                    
                }
            }
            
            }.resume()
      
        
        
    }
    
    @IBAction func star_tapped(_ sender: UIButton) {
        
        no_of_stars = sender.tag + 1
        
         print("***************stars given - \(no_of_stars)" )
        
        for button in star_buttons {
            if( button.tag < no_of_stars)
            {
             
                button.setTitle("★", for: .normal )
                
               
                
            } else {
                
                button.setTitle("☆", for: .normal )
                
            }
        }
    }
    
    
    @IBOutlet var id: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        id.text = String ( orders[selected_row].OrderID )
        
        if( orders[selected_row].Status == "PLACED" )
        {
            
            for button in star_buttons{
                button.isHidden = false
            }
            
        }
        else {
            for button in star_buttons{
                button.isHidden = true
            }
            
        }

   
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

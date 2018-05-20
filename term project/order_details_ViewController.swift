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
    
    struct rating : Decodable {
        let Rating: Int?
    }
    
    var rat = rating(Rating:0)
    
    
    
    @IBOutlet var star_buttons: [UIButton]!
    
    @IBOutlet var error_label: UILabel!
    
    @IBOutlet var rate_button: UIButton!
    
    
    
    
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
            
            "rating": 0,
            
            ] as [String : Any]
        
        parameters["rating"] = no_of_stars
        
        
        
        print("###############################I am in rating action")
        
        
        guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/rating/\(user_email)/\(selected_menu_id)") else { return }
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
        
        self.get_ratings {
            
            
            
            
            self.id.text = selected_menu_name
            
            if( orders[selected_row].Status == "Fulfilled" )
            {
                  self.error_label.isHidden = true
                  self.rate_button.isHidden = false
                
                
                  self.error_label.text = "You have given \(  self.rat.Rating)⭐️s to this menu previously!"
                  self.error_label.isHidden = false
                
                for button in   self.star_buttons{
                    button.isHidden = false
                }
                
                //prev given stars show here
                
                if   self.rat.Rating != 0
                {
                      self.error_label.text = "You have given \(  self.rat.Rating)⭐️s to this menu previously!"
                      self.error_label.isHidden = false
                }
                
                for button in   self.star_buttons {
                    if( button.tag <   self.rat.Rating!)
                    {
                        button.setTitle("★", for: .normal )
                    } else {
                        button.setTitle("☆", for: .normal )
                    }
                }
                
            }
            else {
                
                  self.error_label.isHidden = false
                  self.rate_button.isHidden = true
                for button in   self.star_buttons{
                    button.isHidden = true
                }
            }
            
            
            
        
        }
        
        
    }
    
    
    
    
    // func to get ratings from json
    
    func get_ratings( completion: @escaping ()->() )  {
        
        // get call on https://mobile-ios-backend.herokuapp.com/rating/nikhitha.reddy123@gmail.com/2
        // store in no_of_stars
        
        
        
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/rating/\(user_email)/\(selected_menu_id)"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                self.rat = try JSONDecoder().decode(rating.self, from: data!)
                
                print("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^")
                print(self.rat.Rating)
                
                completion()
            }
            catch{
                print(err)
            }
            
            }.resume()
        
    }
    
    
    
    
    
    
}

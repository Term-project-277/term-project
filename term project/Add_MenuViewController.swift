//
//  Add_MenuViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/4/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class Add_MenuViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    @IBOutlet var menu_name_text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
    }

   
    @IBAction func submit_Action(_ sender: Any) {
        
        
        
        
        var parameters = ["Category": "MainCourse",
                          "Name":  "",
                          "Unitprice": 1000.99,
                          "Calories" : 0,
                          "Preparationtime": 30
            ] as [String : Any]
        
        
        
        parameters["Name"] =  menu_name_text.text
        
 
        guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/menu") else { return }
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
                    self.label.text = "added!"
                } catch {
                    print(error)
                    self.label.text = error as! String
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

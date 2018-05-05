//
//  Add_MenuViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/4/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class Add_MenuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

   
    let cats = ["Drink","Appetizer","MainCourse","Desert"]
    
    var parameters = ["Category": "Drink",
                      "Name":  "",
                      "Unitprice": 0,
                      "Calories" : 0,
                      "Preparationtime": 0
        ] as [String : Any]
    var sel =  false
    
    @IBOutlet var menu_name_text: UITextField!
    @IBOutlet var price: UITextField!
    @IBOutlet var prep: UITextField!
    @IBOutlet var calories: UITextField!
    
    @IBOutlet var picker1: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sel = false
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cats.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            sel = true
            parameters["Category"] = cats[row]
            print(parameters["Category"])
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cats[row]
    }

   
    @IBAction func submit_Action(_ sender: Any) {
        
        if  (sel == false) || menu_name_text.text! == "" || price.text! == ""
            || calories.text == "" || prep.text == ""{
            
            let banner = NotificationBanner(title: "Error !!", subtitle: "Pls select all the 4 numbers", style: .danger)
            banner.show()
        }
        
        else
        {
            
            // "Drink"   "MainCourse"
            parameters["Name"] =  menu_name_text.text
            parameters["Unitprice"] = Int(price.text!)
            parameters["Calories"] = Int(calories.text!)
            parameters["Preparationtime"] = Int(prep.text!)
            
            
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
                        
                    } catch {
                        print(error)
                        
                    }
                }
                
                }.resume()
            
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

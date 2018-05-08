//
//  User_details_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/6/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class User_details_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var quantity:Int = 0
    var name:String = ""
    var price:Double = 0.0
    var category:String = ""
    var calories:Int = 0
    var isSelected:Bool = false
    var MenuID: Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        isSelected = true
        quantity = row + 1
    }
    
   
    @IBAction func addToCart_button(_ sender: Any) {
        print(quantity)
        print(name)
        print(price)
        print(category)
        print(calories)
        if(!isSelected){
        let banner = NotificationBanner(title: "Please select the quantity!", subtitle: "", style: .danger)
        banner.show()
        }
        else
        {
          
            var parameters = [
                              "MenuID":  0,
                              "Quantity": 0,
                ] as [String : Any]
            
            
            
            parameters["MenuID"] = MenuID
            parameters["Quantity"] = quantity
            
            // put call on cart
            
            
            guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/cart/shwetha@gmail.com") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
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
                        
                        let banner = NotificationBanner(title: "\(self.quantity) \(self.name) added to cart successfully! ", subtitle: "", style: .danger)
                        banner.show()
                        
                    } catch {
                        print(error)
                        
                    }
                }
                
                }.resume()
        }
        
    }
    
    
    @IBOutlet weak var calories_label: UILabel!
    @IBOutlet weak var price_label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name_label: UILabel!
    @IBOutlet weak var quantityPicker: UIPickerView!
    var pickerData: [String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quantityPicker.delegate = self
        self.quantityPicker.dataSource = self
        pickerData = ["1", "2", "3", "4", "5"]
        
        if selected_section == 0
        {
             MenuID = drinks[selected_row].ID
            name = drinks[selected_row].Name
            price = drinks[selected_row].Unitprice
            calories = drinks[selected_row].Calories!
            name_label.text = name
            category = "Drinks"
            imageView.image = UIImage(named: name)
            price_label.text = String(price)
            calories_label.text = String(calories)
            category_label.text = category
        }
        
        if selected_section == 1
        {
             MenuID = appets[selected_row].ID
            name = appets[selected_row].Name
            price = appets[selected_row].Unitprice
            calories = appets[selected_row].Calories!
            name_label.text = name
            category = "Appetizers"
            imageView.image = UIImage(named: name)
            price_label.text = String(price)
            calories_label.text = String(calories)
            category_label.text = category
        }
        if selected_section == 2
        {
             MenuID = mains[selected_row].ID
            name = mains[selected_row].Name
            price = mains[selected_row].Unitprice
            calories = mains[selected_row].Calories!
            name_label.text = name
            category = "Main Course"
            imageView.image = UIImage(named: name)
            price_label.text = String(price)
            calories_label.text = String(calories)
            category_label.text = category
        }
        if selected_section == 3
        {
             MenuID = deserts[selected_row].ID
            name = deserts[selected_row].Name
            price = deserts[selected_row].Unitprice
            calories = deserts[selected_row].Calories!
            name_label.text = name
            category = "Deserts"
            imageView.image = UIImage(named: name)
            price_label.text = String(price)
            calories_label.text = String(calories)
            category_label.text = category
        }
        

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var category_label: UILabel!
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

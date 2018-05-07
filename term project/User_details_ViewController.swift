//
//  User_details_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/6/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
var sel = false
class User_details_ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
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
            var name = drinks[selected_row].Name
            imageView.image = UIImage(named: name)
            name_label.text = name
            price_label.text = String( drinks[selected_row].Unitprice )
            calories_label.text = String(drinks[selected_row].Calories!)
            category_label.text = "Drinks"
        }
        
        if selected_section == 1
        {
            var name = appets[selected_row].Name
            imageView.image = UIImage(named: name)
            name_label.text = name
            price_label.text =  String( appets[selected_row].Unitprice )
            calories_label.text = String(appets[selected_row].Calories!)
            category_label.text = "Appetizers"
        }
        if selected_section == 2
        {
            var name = mains[selected_row].Name
            imageView.image = UIImage(named: name)
            name_label.text = name
            price_label.text = String( mains[selected_row].Unitprice )
            calories_label.text = String(mains[selected_row].Calories!)
            category_label.text = "Main Course"
        }
        if selected_section == 3
        {
            var name = deserts[selected_row].Name
            imageView.image = UIImage(named: name)
            name_label.text = name
            price_label.text = String( deserts[selected_row].Unitprice )
            calories_label.text = String(deserts[selected_row].Calories!)
            category_label.text = "Deserts"
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

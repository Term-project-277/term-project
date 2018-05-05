//
//  DetailsViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/1/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit



class DetailsViewController: UIViewController {
    
   
    @IBOutlet var name_label: UILabel!
    @IBOutlet var price_label: UILabel!
    @IBOutlet var prep_time_label: UILabel!
    @IBOutlet var category_label: UILabel!
    @IBOutlet var calories_label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if selected_section == 0
//        {
//            name_label.text = drinks[selected_row].Name
//            price_label.text = String( drinks[selected_row].Unitprice )
//            prep_time_label.text = String(drinks[selected_row].Preparationtime!)
//            calories_label.text = String(drinks[selected_row].Calories!)
//            category_label.text = "Drinks"
//        }
//        
//        if selected_section == 1
//        {
//            name_label.text = appets[selected_row].Name
//            price_label.text = String( appets[selected_row].Unitprice )
//            prep_time_label.text = String(appets[selected_row].Preparationtime!)
//            calories_label.text = String(appets[selected_row].Calories!)
//            category_label.text = "Appetizers"
//        }
//        if selected_section == 2
//        {
//            name_label.text = mains[selected_row].Name
//            price_label.text = String( mains[selected_row].Unitprice )
//            prep_time_label.text = String(mains[selected_row].Preparationtime!)
//            calories_label.text = String(mains[selected_row].Calories!)
//            category_label.text = "Main Course"
//        }
//        if selected_section == 3
//        {
//            name_label.text = deserts[selected_row].Name
//            price_label.text = String( deserts[selected_row].Unitprice )
//            prep_time_label.text = String(deserts[selected_row].Preparationtime!)
//            calories_label.text = String(deserts[selected_row].Calories!)
//            category_label.text = "Deserts"
//        }
//        
         
        
      
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

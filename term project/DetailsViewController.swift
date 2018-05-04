//
//  DetailsViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/1/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit



class DetailsViewController: UIViewController {
    
   

    @IBOutlet var deatils_label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selected_section == 0
        {
                deatils_label.text = drinks[selected_row].Name
        }
        
        if selected_section == 1
        {
            deatils_label.text = appets[selected_row].Name
        }
        if selected_section == 2
        {
            deatils_label.text = mains[selected_row].Name
        }
        if selected_section == 3
        {
            deatils_label.text = deserts[selected_row].Name
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

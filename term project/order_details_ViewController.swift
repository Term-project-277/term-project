//
//  order_details_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/15/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class order_details_ViewController: UIViewController {

    
    
    @IBOutlet var star_buttons: [UIButton]!
    
    
    
    @IBAction func star_tapped(_ sender: UIButton) {
        
        let tag = sender.tag
        
         print("***************stars given - \(tag+1)" )
        
        for button in star_buttons {
            if( button.tag <= tag)
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

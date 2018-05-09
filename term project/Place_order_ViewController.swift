//
//  Place_order_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/8/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class Place_order_ViewController: UIViewController {

    @IBOutlet var date_picker: UIDatePicker!
    
    @IBAction func date_picker(_ sender: Any) {

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func date(_ sender: Any) {
        
        
        date_picker.timeZone = TimeZone.init(secondsFromGMT: 0)
       
       print( date_picker.date )
        
    }
    @IBAction func datepicker_action(_ sender: Any) {
       
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

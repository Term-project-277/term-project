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
    
    @IBOutlet weak var time_picker: UIDatePicker!
    
    //var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    


    @IBAction func date(_ sender: Any) {
        
        
        date_picker.timeZone = TimeZone.init(secondsFromGMT: 0)
        let currentDate = Date()
        let oneDay = 24 * 60 * 60
        let minDate = currentDate.addingTimeInterval(TimeInterval(0 * oneDay))
        let maxDate = currentDate.addingTimeInterval(TimeInterval(7 * oneDay))
        date_picker.minimumDate = minDate
        date_picker.maximumDate = maxDate
        
    }
    
    @IBAction func timepicker_action(_ sender: Any) {
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

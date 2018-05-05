//
//  AdminLoginViewController.swift
//  term project
//
//  Created by Nod on 5/5/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

class AdminLoginViewController: UIViewController {
    let adminUserName = "Thrishna"
    let adminPassword = "cmpe@277"
    var userName = ""
    var pword = ""

    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var password: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func login_button(_ sender: Any) {
        userName = username.text!
        pword = password.text!
        if(userName == adminUserName && pword == adminPassword){
        self.performSegue(withIdentifier: "adminLoginIdentifier", sender: self)
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

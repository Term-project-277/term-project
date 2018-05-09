//
//  AdminLoginViewController.swift
//  term project
//
//  Created by Nod on 5/5/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import NotificationBannerSwift

class AdminLoginViewController: UIViewController {
    let adminUserName = "admin"
    let adminPassword = "admin"
    var userName = ""
    var pword = ""

    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        

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
        else{
            let banner = NotificationBanner(title: "Invalid Credentials!", subtitle: "Please enter valid admin user name and password!", style: .info
            )
            banner.show()
            
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

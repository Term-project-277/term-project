//
//  ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 4/24/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let loginButton = FBSDKLoginButton()
        
        view.addSubview(loginButton)
        
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width-32, height: 50)
        
        loginButton.delegate =  self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out ")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
             print(error)
            return
        }
        print("successfully  logged in ! ")
        
        
    }
    


    
    


}


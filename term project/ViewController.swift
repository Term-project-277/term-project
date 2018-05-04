//
//  ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 4/24/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//


import UIKit
import FBSDKLoginKit

import GoogleSignIn
import GoogleToolboxForMac




class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width-32, height: 50)
        loginButton.delegate =  self
        
       
        // for Google
        var error: NSError?
        if(error != nil){
            print(error)
            return
        }
        GIDSignIn.sharedInstance().clientID = "868442633715-a9elkntjjet7hsvvdlas1fjmrrck01c8.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        let google_signin = GIDSignInButton()
        view.addSubview(google_signin)
        google_signin.frame = CGRect(x: 16, y: 150, width: view.frame.width-32, height: 50)
       
        GIDSignIn.sharedInstance().uiDelegate  =  self
        
        
        

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        if error != nil
        {
            print(error)
            label.text = "Could not signed into Google!"
            
        }
        else{
         
            print("@@@@@@@@@@@@@@@@@@@@@@@@@ " + user.profile.email)
            
           label.text = "Successsfully signed into Google!"
        }

    }
    
    
    @IBOutlet var label: UILabel!
   
    @IBOutlet var google_sign_out: UIButton!
    @IBAction func google_signout(_ sender: Any) {
         GIDSignIn.sharedInstance().signOut()
        label.text = "Successsfully signed Out of Google!"
      
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


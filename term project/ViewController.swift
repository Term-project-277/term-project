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


var user_email = ""




class ViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    @IBOutlet var Google_signout: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make google logout button look good here
        Google_signout.bounds = CGRect(x: 30, y: 450, width: view.frame.width-80, height: 30)
    
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 30, y: 250, width: view.frame.width-62, height: 50)
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
        google_signin.frame = CGRect(x: 30, y: 350, width: view.frame.width-62, height: 50)
       
        GIDSignIn.sharedInstance().uiDelegate  =  self
        
        
        

    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        
        if error != nil
        {
            print(error)
            label.text = "Could not signed into Google!"
            
        }
        else{
         
            user_email = user.profile.email
            print("@@@@@@@@@@@@@@@@@@@@@@@@@ " + user.profile.email)
            
            // do post on  https://mobile-ios-backend.herokuapp.com/cart/ with
                //request payload ->
//            {        "User": "shiva322@gmail.com"
//            } to create cart
            
            var parameters = [
                              "User":  ""
                              
                ] as [String : Any]
            
            parameters["User"] = user_email
            
            guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/cart/") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
                }.resume()
            
            performSegue(withIdentifier: "user_logged_in1", sender: self )
            
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
        
        else{
            
            fetchProfile()
            
            var parameters = [
                "User":  ""
                
                ] as [String : Any]
            
            parameters["User"] = user_email
            
            guard let url = URL(string: "https://mobile-ios-backend.herokuapp.com/cart/") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
                }.resume()
            
            performSegue(withIdentifier: "user_logged_in1", sender: self )
            
            
        }
        
        print("successfully  logged in ! ")
        
        
    }
    
    func fetchProfile(){
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "email, name, id, gender"])
            .start(completionHandler:  { (connection, result, error) in
                guard let result = result as? NSDictionary, let email = result["email"] as? String,
                    let user_name = result["name"] as? String,
                    let user_gender = result["gender"] as? String,
                    let user_id_fb = result["id"]  as? String
                    else {
                        return
                }
                
                user_email = email
            })

    }
    


    
    


}


//
//  Admin_more_Actions_ViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/18/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

import NotificationBannerSwift

class Admin_more_Actions_ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func reset_orders(_ sender: Any) {
        
        
            let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/order/adminreset"
            
            var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
            firstTodoUrlRequest.httpMethod = "POST"
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: firstTodoUrlRequest) {
                (data, response, error) in
                guard let _ = data else {
                    print("error calling POST on")
                    return
                }
                print(" reset orders ok")
                
                DispatchQueue.main.async {
                    
                    let banner = NotificationBanner(title: "Reset orders Successful! ", subtitle: "", style: .success)
                    banner.show()
                    
                }
            }
            task.resume()
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

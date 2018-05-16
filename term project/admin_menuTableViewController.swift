//
//  admin_menuTableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/1/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

struct appet : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

 var appets = [appet] ()

struct drink : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

var drinks = [drink] ()


struct main : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

var mains = [main] ()

struct desert : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

var deserts = [desert] ()


var cat2 = [String] ()  // Appetizers
var cat3 = [String] ()  // Main course
var cat4 = [String] ()  // dessert

var selected_section = 0
var selected_row = 0




let cellID = "id"

class admin_menuTableViewController: UITableViewController {

    
    @IBAction func reset_orders_action(_ sender: Any) {
        
        
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
        }
        task.resume()

        
        
    }
    
    
    @IBOutlet var lab: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableViewAutomaticDimension
        
      
        
        loadAppetizers()
        loadDrink()
        loadMain()
        loadDesert()
        
    }
    
    func loadAppetizers()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Appetizer"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                appets = try JSONDecoder().decode([appet].self, from: data!)
                
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadDrink()
    {
       
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Drink"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                    drinks = try JSONDecoder().decode([drink].self, from: data!)
                    self.tableView.reloadData()
                }
                catch{
                    print(err)
                }
            }.resume()
    }
    
    func loadDesert()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Desert"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                deserts = try JSONDecoder().decode([desert].self, from: data!)
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadMain()
    {
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/MainCourse"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                mains = try JSONDecoder().decode([main].self, from: data!)
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    
    
    


    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
    
        if section == 0 {
                 label.text = "Drink"
        }
        if section == 1 {
            label.text = "Appetizer"
        }
        if section == 2 {
            label.text = "Main course"
        }
        if section == 3 {
            label.text = "Desert"
        }
       
        label.font = label.font.withSize(40)
        label.textColor = UIColor.black
        label.backgroundColor = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
        return label
  
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0
        {
                return drinks.count
        }
        if section == 1
        {
            return appets.count
        }
        if section == 2
        {
            
            return mains.count
        }
        if section == 3
        {
            return deserts.count
        }
        
        return 2
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[.foregroundColor] = UIColor.brown
        attributes[.font] = UIFont.boldSystemFont(ofSize: 32) as AnyObject
  
        
        if indexPath.section == 0 {
          
            let attributedString = NSMutableAttributedString(string: "\( drinks[indexPath.row].Name )\n", attributes:attributes)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "\(drinks[indexPath.row].Name).jpg")
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(drinks[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(drinks[indexPath.row].Calories!)\n\t\t\t\t\tUnit price: \(drinks[indexPath.row].Unitprice)")
            attributedString.append(normalString)
            
            // create our NSTextAttachment
            
            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 1 {
         let attributedString = NSMutableAttributedString(string: "\( appets[indexPath.row].Name )\n ", attributes:attributes)
            var name:String = "\(appets[indexPath.row].Name)"
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "\(name).jpg")
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(appets[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(appets[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(appets[indexPath.row].Unitprice)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 2 {
            
             let attributedString = NSMutableAttributedString(string: "\( mains[indexPath.row].Name )\n ", attributes:attributes)
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named:"\(mains[indexPath.row].Name).jpg")
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(mains[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(mains[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(mains[indexPath.row].Unitprice)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
            
        }
        if indexPath.section == 3 {
            
             let attributedString = NSMutableAttributedString(string: "\(deserts[indexPath.row].Name)\n ", attributes:attributes)
            /*let normalString = NSMutableAttributedString(string: "Prep time: \(deserts[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(deserts[indexPath.row].Calories!)\n\t\t\t\t\tUnit price: \(deserts[indexPath.row].Unitprice)")
            attributedString.append(normalString)*/
            let image1Attachment = NSTextAttachment()
            image1Attachment.image = UIImage(named: "\(deserts[indexPath.row].Name).jpg")
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(deserts[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(deserts[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(deserts[indexPath.row].Unitprice) \t\tID : \(deserts[indexPath.row].ID)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
            
            
        }
        

        return cell
    }
 

   
//     Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//         Return false if you do not want the specified item to be editable.
        return true
    }
 

    
//     Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
          
//             Delete the row from the data source
            if indexPath.section == 0
            {
                var s = String(drinks[indexPath.row].ID)
                let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/menu/" + s
                
                var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
                firstTodoUrlRequest.httpMethod = "DELETE"
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: firstTodoUrlRequest) {
                    (data, response, error) in
                    guard let _ = data else {
                        print("error calling DELETE on /todos/1")
                        return
                    }
                    print("DELETE ok")
                }
                task.resume()
                
                loadDrink()
               
            }
            if indexPath.section == 1
            {
                var s = String(appets[indexPath.row].ID)
                let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/menu/" + s
                
                var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
                firstTodoUrlRequest.httpMethod = "DELETE"
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: firstTodoUrlRequest) {
                    (data, response, error) in
                    guard let _ = data else {
                        print("error calling DELETE on /todos/1")
                        return
                    }
                    print("DELETE ok")
                }
                task.resume()
                
                loadAppetizers()
                
            }
            if indexPath.section == 2
            {
                var s = String(mains[indexPath.row].ID)
                let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/menu/" + s
                
                var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
                firstTodoUrlRequest.httpMethod = "DELETE"
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: firstTodoUrlRequest) {
                    (data, response, error) in
                    guard let _ = data else {
                        print("error calling DELETE on /todos/1")
                        return
                    }
                    print("DELETE ok")
                }
                task.resume()
                
                loadMain()
               
            }
            if indexPath.section == 3
            {
                
                var s = String(deserts[indexPath.row].ID)
                let firstTodoEndpoint: String = "https://mobile-ios-backend.herokuapp.com/menu/" + s
                
                var firstTodoUrlRequest = URLRequest(url: URL(string: firstTodoEndpoint)!)
                firstTodoUrlRequest.httpMethod = "DELETE"

                let session = URLSession.shared

                let task = session.dataTask(with: firstTodoUrlRequest) {
                    (data, response, error) in
                    guard let _ = data else {
                        print("error calling DELETE on /todos/1")
                        return
                    }
                    print("DELETE ok")
                }
                task.resume()

                loadDesert()
                
            }
            
           
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selected_section =  indexPath.section
        selected_row =  indexPath.row
        
        performSegue(withIdentifier:"deatils_segue" , sender: self)
    }


    @IBAction func logout_button(_ sender: Any) {
        performSegue(withIdentifier:"logout_identifier" , sender: self)
    }
    


//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        var detailC = DetailsViewController
//    }
   

}

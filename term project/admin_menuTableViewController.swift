//
//  admin_menuTableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/1/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit

struct appet : Decodable {
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

 var appets = [appet] ()

struct drink : Decodable {
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

var drinks = [drink] ()


struct main : Decodable {
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
}

var mains = [main] ()

struct desert : Decodable {
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
        label.textColor = UIColor.white
        label.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
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
  
        
        if indexPath.section == 0 {
            
            var attributes = [NSAttributedStringKey: AnyObject]()
            attributes[.foregroundColor] = UIColor.brown
            attributes[.font] = UIFont.boldSystemFont(ofSize: 34) as AnyObject
            
            print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
            
           
            let attributedString = NSMutableAttributedString(string: "\( drinks[indexPath.row].Name ) \n ", attributes:attributes)
            let normalString = NSMutableAttributedString(string: "Prep time :  \(drinks[indexPath.row].Preparationtime!)  \t Calories : \(drinks[indexPath.row].Calories!) \t Unit price :\(drinks[indexPath.row].Unitprice)")
            attributedString.append(normalString)
           

            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = "\( appets[indexPath.row].Name ) \t Prep time :  \(appets[indexPath.row].Preparationtime!)  \t Calories : \(appets[indexPath.row].Calories!) \t Unit price :\(appets[indexPath.row].Unitprice) "
        }
        if indexPath.section == 2 {
            cell.textLabel?.text = "\( mains[indexPath.row].Name ) \t Prep time :  \(mains[indexPath.row].Preparationtime!)  \t Calories : \(mains[indexPath.row].Calories!) \t Unit price :\(mains[indexPath.row].Unitprice) "
        }
        if indexPath.section == 3 {
            cell.textLabel?.text = "\( deserts[indexPath.row].Name ) \t Prep time :  \(deserts[indexPath.row].Preparationtime!)  \t Calories : \(deserts[indexPath.row].Calories!) \t Unit price :\(deserts[indexPath.row].Unitprice) "
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
                drinks.remove(at: indexPath.row)
               
                tableView.reloadData()
            }
            if indexPath.section == 1
            {
                appets.remove(at: indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 2
            {
                mains.remove(at: indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 3
            {
                deserts.remove(at: indexPath.row)
                tableView.reloadData()
            }
            
           
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selected_section =  indexPath.section
        selected_row =  indexPath.row
        
        performSegue(withIdentifier:"deatils_segue" , sender: self)
    }





//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//
//        var detailC = DetailsViewController
//    }
   

}
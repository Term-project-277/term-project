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
}

 var appets = [appet] ()

struct drink : Decodable {
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
}

var drinks = [drink] ()

var cat1 = [String] ()  // Drink
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
        
        loadAppetizers()
        loadDrink()
        loadMain()
        loadDesert()
        
    }
    
    func loadAppetizers()
    {
        print("in tabeleview ####################################00000@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(cat3)
        print(cat3.count)
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Appetizer"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                appets = try JSONDecoder().decode([appet].self, from: data!)
                
                cat2.removeAll()
                
                for eachAppet in appets {
                    print(eachAppet.Name)
                    cat2.append(eachAppet.Name)
                    print(cat2)
                    self.tableView.reloadData()
                }
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadDrink()
    {
        print("in tabeleview ####################################00000@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(cat3)
        print(cat3.count)
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Drink"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                drinks = try JSONDecoder().decode([drink].self, from: data!)
                
                cat1.removeAll()
                
                for eachAppet in drinks {
                    print(eachAppet.Name)
                    cat1.append(eachAppet.Name)
                    
                    print(cat1)
                    self.tableView.reloadData()
                }
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadDesert()
    {
        print("in tabeleview ####################################00000@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(cat3)
        print(cat3.count)
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/Desert"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                appets = try JSONDecoder().decode([appet].self, from: data!)
                cat4.removeAll()
                
                for eachAppet in appets {
                    print(eachAppet.Name)
                    cat4.append(eachAppet.Name)
                    print(cat4)
                    self.tableView.reloadData()
                }
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadMain()
    {
        print("in tabeleview ####################################00000@@@@@@@@@@@@@@@@@@@@@@@@@@@")
        print(cat3)
        print(cat3.count)
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/menu/MainCourse"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                appets = try JSONDecoder().decode([appet].self, from: data!)
                cat3.removeAll()
                
                for eachAppet in appets {
                    print(eachAppet.Name)
                    cat3.append(eachAppet.Name)
                    print(cat3)
                    self.tableView.reloadData()
                }
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
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
        
        
        print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
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
                return cat1.count
        }
        if section == 1
        {
            return cat2.count
        }
        if section == 2
        {
            
            return cat3.count
        }
        if section == 3
        {
            return cat4.count
        }
        
        return 2
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)

        if indexPath.section == 0 {
            cell.textLabel?.text = "\( cat1[indexPath.row] ) \t Prep time :  \(drinks[indexPath.row].Preparationtime!)  \t Calories : \(drinks[indexPath.row].Calories!)"
        }
        if indexPath.section == 1 {
            cell.textLabel?.text = cat2[indexPath.row]
        }
        if indexPath.section == 2 {
            cell.textLabel?.text = cat3[indexPath.row]
        }
        if indexPath.section == 3 {
            cell.textLabel?.text = cat4[indexPath.row]
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
                cat1.remove(at: indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 1
            {
                cat2.remove(at: indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 2
            {
                cat3.remove(at: indexPath.row)
                tableView.reloadData()
            }
            if indexPath.section == 3
            {
                cat4.remove(at: indexPath.row)
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

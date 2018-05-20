//
//  poularity_report_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/18/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit



struct appet_pop : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
    let Popularity: Int
}

var appets_pop = [appet_pop] ()

struct drink_pop : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
    let Popularity: Int
}

var drinks_pop = [drink_pop] ()


struct main_pop : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
    let Popularity: Int
}

var mains_pop = [main_pop] ()

struct desert_pop : Decodable {
    let ID : Int
    let Name : String
    let Preparationtime: Int?
    let Calories: Int?
    let Unitprice: Double
    let Popularity: Int
}

var deserts_pop = [desert_pop] ()


class poularity_report_TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        
        loadAppetizers()
        loadDrink()
        loadMain()
        loadDesert()
        
    }
    
    func loadAppetizers()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/order/popularityreport/Appetizer"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                appets_pop = try JSONDecoder().decode([appet_pop].self, from: data!)
                
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    func loadDrink()
    {
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/order/popularityreport/Drink"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                drinks_pop = try JSONDecoder().decode([drink_pop].self, from: data!)
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            }.resume()
    }
    
    func loadDesert()
    {
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/order/popularityreport/Desert"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                deserts_pop = try JSONDecoder().decode([desert_pop].self, from: data!)
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func loadMain()
    {
        
        let jsonurl = "https://mobile-ios-backend.herokuapp.com/order/popularityreport/MainCourse"
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                mains_pop = try JSONDecoder().decode([main_pop].self, from: data!)
                self.tableView.reloadData()
            }
            catch{
                print(err)
            }
            
            }.resume()
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
            return drinks_pop.count
        }
        if section == 1
        {
            return appets_pop.count
        }
        if section == 2
        {
            
            return mains_pop.count
        }
        if section == 3
        {
            return deserts_pop.count
        }
        
        return 2
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
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[.foregroundColor] = UIColor.brown
        attributes[.font] = UIFont.boldSystemFont(ofSize: 32) as AnyObject
        
        
        if indexPath.section == 0 {
            
            let attributedString = NSMutableAttributedString(string: "\(drinks_pop[indexPath.row].Name)\n ", attributes:attributes)
            
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(drinks_pop[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(drinks_pop[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(drinks_pop[indexPath.row].Unitprice) \n\t\tPopularity : \(drinks_pop[indexPath.row].Popularity)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 1 {
            let attributedString = NSMutableAttributedString(string: "\(appets_pop[indexPath.row].Name)\n ", attributes:attributes)
            
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(appets_pop[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(appets_pop[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(appets_pop[indexPath.row].Unitprice) \n\t\tPopularity : \(appets_pop[indexPath.row].Popularity)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 2 {
            
            let attributedString = NSMutableAttributedString(string: "\(mains_pop[indexPath.row].Name)\n ", attributes:attributes)
            
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(mains_pop[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(mains_pop[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(mains_pop[indexPath.row].Unitprice) \n\t\tPopularity : \(mains_pop[indexPath.row].Popularity)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
            
        }
        
        if indexPath.section == 3 {
            
            let attributedString = NSMutableAttributedString(string: "\(deserts[indexPath.row].Name)\n ", attributes:attributes)
           
            let normalString = NSMutableAttributedString(string: "\t\tPrep time: \(deserts_pop[indexPath.row].Preparationtime!)\n\t\tCalories: \(deserts_pop[indexPath.row].Calories!)\n\t\tUnit price : \(deserts_pop[indexPath.row].Unitprice) \n\t\tPopularity : \(deserts_pop[indexPath.row].Popularity)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
            
            
        }
        
        
        return cell
    }


}

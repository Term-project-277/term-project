//
//  User_menu_TableViewController.swift
//  term project
//
//  Created by Shweta Kothari on 5/6/18.
//  Copyright © 2018 Shweta Kothari. All rights reserved.
//

import UIKit





class User_menu_TableViewController: UITableViewController {

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
        
    
        
        return 0
    }
    
    
    @objc func buttonClicked(sender:UIButton)
    {
        
        var o = "select how you want to sort!!! "
        let alert = UIAlertController(title: o, message: "", preferredStyle: .alert)
        
        
        if(sender.tag == 0){
            
            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
            var pr1 = "https://mobile-ios-backend.herokuapp.com/menu/Drink/Price"
            var n1 = "https://mobile-ios-backend.herokuapp.com/menu/Drink/Name"
              var po1 = "https://mobile-ios-backend.herokuapp.com/menu/Drink/Popularity"
            
            
            alert.addAction(UIAlertAction(title: "Price", style: .default, handler: { action in self.sort_price(x: pr1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Popularity", style: .default, handler: { action in self.sort_popularity(x: po1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Name", style: .default, handler: { action in self.sort_name( x: n1 , y: sender.tag) } ))
        }
        
        if(sender.tag == 1){
            
            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
            var pr1 = "https://mobile-ios-backend.herokuapp.com/menu/Appetizer/Price"
            var n1 = "https://mobile-ios-backend.herokuapp.com/menu/Appetizer/Name"
            var po1 = "https://mobile-ios-backend.herokuapp.com/menu/Appetizer/Popularity"
            
            
            alert.addAction(UIAlertAction(title: "Price", style: .default, handler: { action in self.sort_price(x: pr1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Popularity", style: .default, handler: { action in self.sort_popularity(x: po1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Name", style: .default, handler: { action in self.sort_name( x: n1 , y: sender.tag) } ))
        }
        
        if(sender.tag == 2){
            
            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
            var pr1 = "https://mobile-ios-backend.herokuapp.com/menu/MainCourse/Price"
            var n1 = "https://mobile-ios-backend.herokuapp.com/menu/MainCourse/Name"
              var po1 = "https://mobile-ios-backend.herokuapp.com/menu/MainCourse/Popularity"
            
            
            alert.addAction(UIAlertAction(title: "Price", style: .default, handler: { action in self.sort_price(x: pr1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Popularity", style: .default, handler: { action in self.sort_popularity(x: po1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Name", style: .default, handler: { action in self.sort_name( x: n1 , y: sender.tag) } ))
        }
        
        if(sender.tag == 3){
            
            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&")
            var pr1 = "https://mobile-ios-backend.herokuapp.com/menu/Desert/Price"
            var n1 = "https://mobile-ios-backend.herokuapp.com/menu/Desert/Name"
              var po1 = "https://mobile-ios-backend.herokuapp.com/menu/Desert/Popularity"
            
            
            
            alert.addAction(UIAlertAction(title: "Price", style: .default, handler: { action in self.sort_price(x: pr1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Popularity", style: .default, handler: { action in self.sort_popularity(x: po1 , y: sender.tag) } ))
            alert.addAction(UIAlertAction(title: "Name", style: .default, handler: { action in self.sort_name( x: n1 , y: sender.tag) } ))
        }
        
        
        
        
        
         self.present(alert, animated: true)
        
        print("buttonClicked")
    }
    
    func sort_price( x : String , y : Int)  {
        print("sorting by price")
        
        //https://mobile-ios-backend.herokuapp.com/menu/MainCourse/Price
        
        
        let jsonurl = x
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                
                if( y == 0)
                {
                   drinks = try JSONDecoder().decode([drink].self, from: data!)
                }
                if( y == 1)
                {
                    appets = try JSONDecoder().decode([appet].self, from: data!)
                }
                if( y == 2)
                {
                    mains = try JSONDecoder().decode([main].self, from: data!)
                }
                if( y == 3)
                {
                    deserts = try JSONDecoder().decode([desert].self, from: data!)
                }
                
             
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // your code here
                    self.tableView.reloadData()
                }
                
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    func sort_popularity(x : String , y : Int) {
        print("sorting by popularity")
        
        let jsonurl = x
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                if( y == 0)
                {
                    drinks = try JSONDecoder().decode([drink].self, from: data!)
                }
                if( y == 1)
                {
                    appets = try JSONDecoder().decode([appet].self, from: data!)
                }
                if( y == 2)
                {
                    mains = try JSONDecoder().decode([main].self, from: data!)
                }
                if( y == 3)
                {
                    deserts = try JSONDecoder().decode([desert].self, from: data!)
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    // your code here
                    self.tableView.reloadData()
                }
                
            }
            catch{
                print(err)
            }
            
            }.resume()
        
    }
    
    func sort_name(  x : String , y : Int )  {
        print("sorting by name")
        
        
        let jsonurl = x
        let url = URL(string: jsonurl )
        
        print(url )
        
        URLSession.shared.dataTask(with: url!) { (data, resp, err) in
            
            do {
                if( y == 0)
                {
                    drinks = try JSONDecoder().decode([drink].self, from: data!)
                }
                if( y == 1)
                {
                    appets = try JSONDecoder().decode([appet].self, from: data!)
                }
                if( y == 2)
                {
                    mains = try JSONDecoder().decode([main].self, from: data!)
                }
                if( y == 3)
                {
                    deserts = try JSONDecoder().decode([desert].self, from: data!)
                }
                
                
                DispatchQueue.main.async {
                     self.tableView.reloadData()
                }
               
               
            }
            catch{
                print(err)
            }
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        
         let rect111 = CGRect(x: 0, y: 10, width: 300, height: 40)
        let label = UILabel(frame: rect111)
        
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
        label.backgroundColor =  #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        

      let rect = CGRect(x: 300, y: 10, width: 100, height: 40)
        
        
        
        let frame = tableView.frame
        let button = UIButton(frame: rect)
        button.tag = section
     
        var image:UIImage!
    

        button.setImage(UIImage(named: "connect-arrow-up-down-7.png"), for: UIControlState.normal)
       
      
        button.addTarget(self,action:#selector(buttonClicked),for:.touchUpInside)
        
         let rect1 = CGRect(x: 300, y: 0, width: frame.width, height: frame.height)
        let headerView = UIView(frame: rect)
        headerView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        headerView.addSubview(label)
        
         headerView.addSubview(button)
        
        return headerView
        
    }
    
    
    // height of the section
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(60)
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        var attributes = [NSAttributedStringKey: AnyObject]()
        attributes[.foregroundColor] = UIColor.brown
        attributes[.font] = UIFont.boldSystemFont(ofSize: 32) as AnyObject
        
        
        var attributes11 = [NSAttributedStringKey: AnyObject]()
        attributes11[.foregroundColor] =  #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
        attributes11[.font] = UIFont.boldSystemFont(ofSize: 20) as AnyObject
        
        
        if indexPath.section == 0 {
        
            
            var tt = ""
            if let rat = drinks[indexPath.row].Rating {
                tt = "\(drinks[indexPath.row].Rating!)⭐️s"
            } else {
                tt = "Be the first to rate!"
            }
            
            let attributedString = NSMutableAttributedString(string: "\( drinks[indexPath.row].Name )\n", attributes:attributes)
            let rs  =   NSMutableAttributedString(string: " \t Rating : \(tt)\n", attributes:attributes11)
            attributedString.append(rs)
            let image1Attachment = NSTextAttachment()
            //image1Attachment.image = UIImage(named: "\(drinks[indexPath.row].Name).jpg")
            let drinksName = "\(drinks[indexPath.row].Name)"
            let imName = drinksName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)

            do {
                let url = URL(string: "https://s3-us-west-2.amazonaws.com/cmpe277/\(imName).jpg")
                if(url != nil){
                let data = try Data(contentsOf: url!)
                image1Attachment.image = UIImage(data: data)
                }
            }
            catch{
                print(error)
            }
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\n\t\t\t\t\tCalories: \(drinks[indexPath.row].Calories!)\n\t\t\t\t\tUnit price: \(drinks[indexPath.row].Unitprice) \n ")
            attributedString.append(normalString)
            
            // create our NSTextAttachment
            
            cell.textLabel?.attributedText = attributedString
        }
        
        if indexPath.section == 1 {
            
            
            var tt = ""
            if let rat = appets[indexPath.row].Rating {
                 tt = "\(appets[indexPath.row].Rating!)⭐️s"
            } else {
               tt = "Be the first to rate!"
            }
            
            
           
            
            let attributedString = NSMutableAttributedString(string: "\( appets[indexPath.row].Name )\n ", attributes:attributes)
            let rs  =   NSMutableAttributedString(string: " \t Rating : \(tt)\n", attributes:attributes11)
            attributedString.append(rs)
            var name:String = "\(appets[indexPath.row].Name)"
            let image1Attachment = NSTextAttachment()
            let appetName = "\(appets[indexPath.row].Name)"
            let imName = appetName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            
            do {
                let url = URL(string: "https://s3-us-west-2.amazonaws.com/cmpe277/\(imName).jpg")
                if(url != nil){
                    let data = try Data(contentsOf: url!)
                    image1Attachment.image = UIImage(data: data)
                }
            }
            catch{
                print(error)
            }
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\n\t\t\t\t\tCalories: \(appets[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(appets[indexPath.row].Unitprice) \n \t\t\t\t Rating : \(tt)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
        }
        if indexPath.section == 2 {
            
            var tt = ""
            if let rat = mains[indexPath.row].Rating {
                tt = "\(mains[indexPath.row].Rating!)⭐️s"
            } else {
                tt = "Be the first to rate!"
            }
            
            let attributedString = NSMutableAttributedString(string: "\( mains[indexPath.row].Name )\n ", attributes:attributes)
            let rs  =   NSMutableAttributedString(string: " \t Rating : \(tt)\n", attributes:attributes11)
            attributedString.append(rs)
            let image1Attachment = NSTextAttachment()
            let mainsName = "\(mains[indexPath.row].Name)"
            let imName = mainsName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            
            do {
                let url = URL(string: "https://s3-us-west-2.amazonaws.com/cmpe277/\(imName).jpg")
                if(url != nil){
                    let data = try Data(contentsOf: url!)
                    image1Attachment.image = UIImage(data: data)
                }
            }
            catch{
                print(error)
            }
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\n\t\t\t\t\tCalories: \(mains[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(mains[indexPath.row].Unitprice) \n \t\t\t\t Rating : \(tt)")
            attributedString.append(normalString)
            cell.textLabel?.attributedText = attributedString
            
        }
        
        if indexPath.section == 3 {
            
            var tt = ""
            if let rat = deserts[indexPath.row].Rating {
                tt = "\(deserts[indexPath.row].Rating!)⭐️s"
            } else {
                tt = "Be the first to rate!"
            }
            
            
            let attributedString = NSMutableAttributedString(string: "\(deserts[indexPath.row].Name)\n ", attributes:attributes)
            let rs  =   NSMutableAttributedString(string: " \t Rating : \(tt)\n", attributes:attributes11)
            attributedString.append(rs)
            /*let normalString = NSMutableAttributedString(string: "Prep time: \(deserts[indexPath.row].Preparationtime!)\n\t\t\t\t\tCalories: \(deserts[indexPath.row].Calories!)\n\t\t\t\t\tUnit price: \(deserts[indexPath.row].Unitprice)")
             attributedString.append(normalString)*/
            let image1Attachment = NSTextAttachment()
            let dessertsName = "\(deserts[indexPath.row].Name)"
            let imName = dessertsName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            
            do {
                let url = URL(string: "https://s3-us-west-2.amazonaws.com/cmpe277/\(imName).jpg")
                if(url != nil){
                    let data = try Data(contentsOf: url!)
                    image1Attachment.image = UIImage(data: data)
                }
            }
            catch{
                print(error)
            }
            let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
            image1Attachment.bounds = rect
            // wrap the attachment in its own attributed string so we can append it
            let image1String = NSAttributedString(attachment: image1Attachment)
            attributedString.append(image1String)
            let normalString = NSMutableAttributedString(string: "\n\t\t\t\t\tCalories: \(deserts[indexPath.row].Calories!)\n\t\t\t\t\tUnit price : \(deserts[indexPath.row].Unitprice) \n \t\t\t\t Rating : \(tt)")
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
    
    
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected_section =  indexPath.section
        selected_row =  indexPath.row

        performSegue(withIdentifier:"user_details" , sender: self)
    }

   

}

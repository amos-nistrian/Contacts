//
//  DetailedContactTableViewController.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import UIKit

class DetailedContactTableViewController: UITableViewController {
    
    var contact : Contact?
    
    var isFave : Bool?
    
    
    @IBOutlet weak var starBtn: UIButton!
    
    @IBOutlet weak var faveUnFave: UIButton!

    @IBAction func faveUnFave(_ sender: Any) {
        
        if isFave! {
            
            isFave = false
            
            // "Hide the star"
            (sender as AnyObject).setImage( UIImage.init(named: "Favorite — False"), for: .normal)
            
        }
            
        else{
            
            isFave = true
            
            // Show the star
            (sender as AnyObject).setImage( UIImage.init(named: "Favorite — True"), for: .normal)
            
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
        
        // perform maintenance
        if (contact?.isFavorite != isFave) {
            
            // find which array to search in
            if (contact?.isFavorite)! {
                contact?.isFavorite = isFave!
                regulars.append(contact: contact!)
                regulars.sort()
                favorites.remove(contact: contact!)
            } else {
                contact?.isFavorite = isFave!
                favorites.append(contact: contact!)
                favorites.sort()
                regulars.remove(contact: contact!)
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Contact name is " + "\(contact!.name)")
        
        isFave = (contact?.isFavorite)!
        
        if (isFave)! {
            starBtn.setImage( UIImage.init(named: "Favorite — True"), for: .normal)
        } else {
            starBtn.setImage( UIImage.init(named: "Favorite — False"), for: .normal)
        }
        
        
        // load the data in dict and sectionOrder array
        processContactData(contact : contact!)

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (contact?.count())!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // calculate screen height
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        
        let row = indexPath.row
        
        if (row == 0) {
            return screenHeight/3
        }
        else {
            return screenHeight/8
        }
        
    }
    
    
    // Configure the cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = indexPath.row
        
        if (row == 0) {
            // display big image section
            let cell = tableView.dequeueReusableCell(withIdentifier: "Large Detailed Content Cell", for: indexPath) as! LargeImageTableCell

            // Configure the cell
            cell.nameLabel.text = contact!.name
            cell.companyLabel.text = contact!.companyName
            
            let imgURL = NSURL(string: (contact?.largeImageURL)!)
            if (imgURL != nil) {
                let data = NSData(contentsOf: (imgURL as URL?)!)
                if (data != nil) {
                    cell.profileImage.image = UIImage(data: data! as Data)
                } else {
                    cell.profileImage.image = UIImage(named: "User — Large")
                }
            }

            return cell
        }
        
        else {
            
            // display detailed smaller cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "Small Detailed Content Cell", for: indexPath) as! DetailedSmallerTableCell
            
            // configure the cell
            let txt = sectionOrder[row-1]

            let test = txt == "Home" || txt == "Mobile" || txt == "Work"
            
            switch test {
            
                case true:
                    cell.topLeftLable.text = "PHONE"
                    cell.bottomLeftLabel.text = dict[txt]
                    cell.rightLabel.text = txt
                    break
                case false:
                    cell.topLeftLable.text = txt
                    cell.bottomLeftLabel.text = dict[txt]
                    break
            }
                
            return cell
        }
    }
}

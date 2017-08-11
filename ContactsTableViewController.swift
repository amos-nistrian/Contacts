//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    @IBOutlet var ContactsTable: UITableView!

    var ContactsCollection = [ContactGroup]()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        getJsonData(completion: {
            
            favorites.sort()
            
            regulars.sort()
            
            self.ContactsCollection.append(favorites)
            
            self.ContactsCollection.append(regulars)
            
            self.ContactsTable.reloadData()
        })

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let ContactGroup = ContactsCollection[section]
        
        return ContactGroup.name
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ContactsCollection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group = ContactsCollection[section]
        return group.count()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        // calculate screen height
        let screenSize = UIScreen.main.bounds
        
        let screenHeight = screenSize.height
        
        return screenHeight/8
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactTableViewController,
            
            let indexPath = tableView.indexPathForSelectedRow {
            
            let ContactGroup = ContactsCollection[indexPath.section]
            
            let contact = ContactGroup.group[indexPath.row]
            
            destination.contact = contact
        }
        dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ContactGroup = ContactsCollection[indexPath.section]
        
        if (ContactGroup.name == "FAVORITE CONTACTS") {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Contact Cell", for: indexPath) as! BasicTableCell
            
            // Configure the cell...
            let contact = ContactGroup.group[indexPath.row]
            
            cell.nameLabel.text = contact.name
            
            cell.nameLabel.text = "⭐️ " + contact.name
            
            cell.companyLabel.text = contact.companyName
            
            cell.imgUrl = contact.smallImageURL
            
            let imgURL = NSURL(string: contact.smallImageURL)
            
            if (imgURL != nil) {
            
                let data = NSData(contentsOf: (imgURL as URL?)!)
                
                if (data != nil) {
                  
                    cell.profileImage.image = UIImage(data: data! as Data)
                    
                } else {
                    
                    cell.profileImage.image = UIImage(named: "User Icon Small")
                    
                }
            }

            return cell
        }
            
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Basic Contact Cell R", for: indexPath) as! BasicRTableViewCell
            
            // Configure the cell...
            
            let contact = ContactGroup.group[indexPath.row]
            
            cell.nameLabel.text = contact.name
            
            cell.companyLabel.text = contact.companyName
            
            cell.imgUrl = contact.smallImageURL
            
            let imgURL = NSURL(string: contact.smallImageURL)
            
            if (imgURL != nil) {
            
                let data = NSData(contentsOf: (imgURL as URL?)!)
                
                if (data != nil) {
                    cell.profileImage.image = UIImage(data: data! as Data)
                } else {
                    cell.profileImage.image = UIImage(named: "User Icon Small")
                }
            }
            
            return cell
        }
        
    }
}

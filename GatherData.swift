//
//  GatherData.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import UIKit

// URL of JSON file
let urlString = "https://s3.amazonaws.com/technical-challenge/v3/contacts.json"

var favorites = ContactGroup(name: "FAVORITE CONTACTS")

var regulars = ContactGroup(name: "OTHER CONTACTS")


func getJsonData(completion:@escaping () -> Void){
    
    let url = URL(string: urlString)
    
    URLSession.shared.dataTask(with:url!) { (data, response, error) in
        
        if error != nil {
            print(error ?? "")
        }
            
        else {
            
            do {
                let response = try JSONSerialization.jsonObject(with: data!, options: [])
                loadDataIntoContactObjs(response: response)
            } catch let error as NSError {
                print(error)
            }
        }
        
        completion()
        
    }.resume()
}


func loadDataIntoContactObjs(response: Any){
    let arrayOfDetails = response as? [[String: Any]] ?? []
    
    /* Create Contacts Objects
     - if contact is favorite add it to favorites array
     - else add it to regular contacts array
     */
    
    for i in 0..<arrayOfDetails.count {
        
        let name = arrayOfDetails[i]["name"] as! String
        let id = arrayOfDetails[i]["id"] as! String
        let isFavorite = arrayOfDetails[i]["isFavorite"] as! Bool
        
        let smallImageURL = arrayOfDetails[i]["smallImageURL"] as! String
        let largeImageURL = arrayOfDetails[i]["largeImageURL"] as! String
        let email = arrayOfDetails[i]["emailAddress"] as! String
        let birth = arrayOfDetails[i]["birthdate"] as! String
        
        let address = arrayOfDetails[i]["address"] as! [String: String]
        let street = address["street"]!
        let city = address["city"]!
        let state = address["state"]!
        let country = address["country"]!
        let zip = address["zipCode"]!
        
        // create a new contact
        let contact = Contact( name: name, id: id, isFavorite: isFavorite,
                               smallImageURL: smallImageURL,largeImageURL: largeImageURL,
                               emailAddress: email, birthdate: birth,
                               street: street, city: city, state: state,
                               country: country, zip: zip )
        contact.smallImage = UIImage(named: "User Icon Small")

        
        
        // values which are not guaranteed
        if let company = arrayOfDetails[i]["companyName"] as? String, !company.isEmpty {
            contact.companyName = company
        }
        
        let phone = arrayOfDetails[i]["phone"] as! [String: String]
        
        if let work = phone["work"], !work.isEmpty {
            contact.workPhone = work
        }
        
        if let home = phone["home"], !home.isEmpty {
            contact.homePhone = home
        }
        
        if let mobile = phone["mobile"], !mobile.isEmpty {
            contact.mobilePhone = mobile
        }
        
        // add the contact to the appropriate array
        if (contact.isFavorite) {
            favorites.group.append(contact)
            
        } else {
            regulars.group.append(contact)
        }
    }
}

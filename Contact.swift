//
//  Contact.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import Foundation
import UIKit

class Contact {
    
    let name: String
    
    let id: String
    
    var companyName: String? // may not be present in json
    
    var isFavorite: Bool
    
    let smallImageURL: String
    
    let largeImageURL: String
    
    var smallImage: UIImage?
    
    var largeImage: UIImage?
    
    let emailAddress: String
    
    let birthdate: String
    
    var workPhone: String? // may not be present in json
    
    var homePhone: String? // may not be present in json
    
    var mobilePhone: String? // can be not present in json
    
    let street: String
    
    let city: String
    
    let state: String
    
    let country: String
    
    let zip: String
    
    
    // constructor
    init(name: String, id: String, isFavorite: Bool, smallImageURL: String,
         largeImageURL: String, emailAddress: String, birthdate: String,
         street: String, city: String, state: String, country: String, zip: String) {
        
        self.name = name
        
        self.id = id
        
        self.isFavorite = isFavorite
        
        self.smallImageURL = smallImageURL
        
        self.largeImageURL = largeImageURL
        
        self.emailAddress = emailAddress
        
        self.birthdate = birthdate
        
        self.street = street
        
        self.city = city
        
        self.state = state
        
        self.country = country
        
        self.zip = zip
    }
    
    
    func isContactFavorite() -> Bool {
        return isFavorite
    }
    
    
    func isSetCompany() -> Bool {
        if (companyName != nil) {
            return (companyName?.characters.count)! > 0
        }
        return false
    }
    
    
    func isSetWorkPhone() -> Bool {
        if (workPhone != nil) {
            return (workPhone?.characters.count)! > 0
        }
        return false
    }
    

    func isSetHomePhone() -> Bool {
        if (homePhone != nil) {
            return (homePhone?.characters.count)! > 0
        }
        return false
    }
    
    
    func isSetMobilePhone() -> Bool {
        if (mobilePhone != nil) {
            return (mobilePhone?.characters.count)! > 0
        }
        return false
    }
    
    
    func count() -> Int {
        var total = 4
        if (isSetHomePhone()) {
            total += 1
        }
        if (isSetWorkPhone()) {
            total += 1
        }
        if (isSetMobilePhone()) {
            total += 1
        }
        return total
    }
    
}

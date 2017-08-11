//
//  ProcessDetailedContactData.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import Foundation
import UIKit

// create a dictionary for use to populate label text
var dict = [String : String]()


// used to keep order of the labels ex: home phone should appear first
var sectionOrder = [String]()


func processContactData(contact : Contact) -> Void {
    
    sectionOrder.removeAll()


    if (contact.isSetHomePhone()) {
        sectionOrder.append("Home")
        dict["Home"] = contact.homePhone
    }
    
    if (contact.isSetMobilePhone()) {
        sectionOrder.append("Mobile")
        dict["Mobile"] = contact.mobilePhone
    }
    
    if (contact.isSetWorkPhone()) {
        sectionOrder.append("Work")
        dict["Work"] = contact.workPhone
    }
    
    sectionOrder.append("ADDRESS")
    let addr = contact.street + "\n" + contact.city + ", " + contact.state + " " + contact.zip + ", " + contact.country
    dict["ADDRESS"] = addr
    
    sectionOrder.append("BIRTHDATE")
    dict["BIRTHDATE"] = contact.birthdate
    
    sectionOrder.append("EMAIL")
    dict["EMAIL"] = contact.emailAddress
    
}


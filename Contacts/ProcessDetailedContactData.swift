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
    dict["BIRTHDATE"] = convertDate(dateStr: contact.birthdate)
    
    sectionOrder.append("EMAIL")
    dict["EMAIL"] = contact.emailAddress
    
}

// convert the birthdate ex: 1987-05-11 becomes May 11, 1987
func convertDate(dateStr : String) -> String {

    let formatter = DateFormatter()
    // initially set the format based on your datepicker date
    formatter.dateFormat = "yyyy-MM-dd"
    
    let date = formatter.date(from: dateStr)
    
    let myString = formatter.string(from: date!)
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    //formatter.dateFormat = "dd-MMM-yyyy"
    formatter.dateFormat = "MMMM dd, yyyy"
    
    // again convert your date to string
    let myStringafd = formatter.string(from: yourDate!)
    
    print(myStringafd)
    return(myStringafd)
}


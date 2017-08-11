//
//  ContactGroup.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import Foundation


class ContactGroup {
    
    var name: String
    
    var group = [Contact]()
    
    init(name: String) {
        self.name = name
    }
    
    
    func count() -> Int {
        return group.count
    }
    
    
    func append(contact :Contact) -> Void {
        group.append(contact)
    }
    
    
    func remove(contact :Contact) -> Void {
        var i = 0
        while (i < group.count) {
            // check if two objects are the same refrence
            if (group[i] === contact) {
                group.remove(at: i)
                break
            } else {
                i += 1
            }
        }
    }
    
    
    func sort() -> Void {
        group.sort(by: { $0.name.capitalized < $1.name.capitalized } )
    }
    
}

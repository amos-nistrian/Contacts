//
//  Stack.swift
//  Contacts
//
//  Created by Amos  on 8/10/17.
//  Copyright © 2017 Amos . All rights reserved.
//

import Foundation

public struct Stack<T> {
    var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public mutating func push(_ element: T) {
        array.append(element)
    }
    
//    public mutating func pop() -> T? {
//        return array.popLast()
//    }
    
    public var top: T? {
        return array.last
    }
}

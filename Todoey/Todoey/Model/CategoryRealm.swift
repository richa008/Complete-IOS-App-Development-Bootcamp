//
//  CategoryRealm.swift
//  Todoey
//
//  Created by Richa Deshmukh on 5/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm : Object {
    
    @objc dynamic var name: String = ""
    
    @objc dynamic var backgroundColor: String = ""
    
    let items = List<TodoItemRealm>()
}

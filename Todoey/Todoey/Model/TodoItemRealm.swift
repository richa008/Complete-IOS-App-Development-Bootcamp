//
//  TodoItemRealm.swift
//  Todoey
//
//  Created by Richa Deshmukh on 5/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItemRealm : Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "items")
}

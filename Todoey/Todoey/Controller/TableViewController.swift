//
//  TableViewController.swift
//  Todoey
//
//  Created by Richa Deshmukh on 5/3/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

/*
 * 1. User defaults - Can save only std data types
 * 2. NSCoder to encode custom plist - Can save custom data types
 * 3. Core data
 */

class TodoTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var todos: [TodoItem] = []
    
    // 1. User defaults
    // let userDefaults = UserDefaults.standard
    
    // 2. Create new plist
    // let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoItems.plist")
    
    // 3. Get context from App Delegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        loadData()
    }
    
    // MARK:- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = todos[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK:- Table view deletegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        todos[indexPath.row].done = !todos[indexPath.row].done
        saveData()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- Add todo section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField: UITextField = UITextField()
        
        let alert = UIAlertController(title: "Add a new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newItem = TodoItem(context: self.context)
            newItem.title = alertTextField.text!
            newItem.done = false
            self.todos.append(newItem)
            
            self.saveData()
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Create new item"
            alertTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveData() {
        
        // 1. User defaults - Add
        // self.userDefaults.set(self.todos, forKey: "TodoListArray")
        //
        // 2. Encode values before saving to plist
        // let encoder = PropertyListEncoder()
        //
        // do {
        //     let data = try encoder.encode(self.todos)
        //     try data.write(to: self.dataFilePath!)
        // } catch {
        //     print(error)
        // }
        
        // 3. Core data
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
    
    // MARK:- Get and save data
    
    func loadData(with request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()) {
        
        // 1. User defaults - get
        // if let items = userDefaults.array(forKey: "TodoListArray") as? [String] {
        //      todos = items
        // }
        
        // 2. Fetch from plist
        //        if let data = try? Data(contentsOf: dataFilePath!) {
        //            let decoder = PropertyListDecoder()
        //            do {
        //                todos = try decoder.decode([TodoItem].self, from: data)
        //            } catch {
        //                print(error)
        //            }
        //        }
        
        // Core data
        do {
            todos = try context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
}

// MARK:- Search bar delegate
extension TodoTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with: request)
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            loadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
    
}


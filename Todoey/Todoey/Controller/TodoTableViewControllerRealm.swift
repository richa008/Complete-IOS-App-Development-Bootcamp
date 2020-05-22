//
//  TodoTableViewControllerRealm.swift
//  Todoey
//
//  Created by Richa Deshmukh on 5/21/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class TodoTableViewControllerRealm: SwipeTableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let realm = try! Realm()
    var todoItems: Results<TodoItemRealm>?
    var selectedCategory: CategoryRealm? {
        didSet {
            loadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let colourHex = selectedCategory?.backgroundColor {
            title = selectedCategory!.name
            guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
            }
            if let navBarColour = UIColor(hexString: colourHex) {
                navBar.barTintColor = navBarColour
                navBar.tintColor = ContrastColorOf(navBarColour, returnFlat: true)
                navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: ContrastColorOf(navBarColour, returnFlat: true)]
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
            
            let colorPercent = CGFloat(indexPath.row)/CGFloat(todoItems!.count)
            
            if let color = UIColor(hexString: selectedCategory!.backgroundColor)?.darken(byPercentage: colorPercent) {
                cell.backgroundColor = color
                cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
                cell.tintColor = ContrastColorOf(color, returnFlat: true)
            }
        } else {
            cell.textLabel?.text = K.TodoList.noItems
        }

        return cell
    }
    
    // MARK:- data manipulation methods
    
    func loadData() {
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let item = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(item)
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK:- Table view deletegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = self.todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    item.done = !item.done
                }
            } catch {
                print(error)
            }
        }

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK:- Add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField: UITextField = UITextField()
        let alert = UIAlertController(title: K.TodoList.addItem, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: K.add, style: .default) { (action) in
            
            if let category = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = TodoItemRealm()
                        newItem.title = alertTextField.text!
                        category.items.append(newItem)
                    }
                } catch {
                    print(error)
                }
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = K.TodoList.addItem
            alertTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK:- Search bar delegate

extension TodoTableViewControllerRealm: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
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

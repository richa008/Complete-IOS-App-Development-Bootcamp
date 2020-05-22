//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Richa Deshmukh on 5/20/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryTableViewController: SwipeTableViewController {
    
    var categories: Results<CategoryRealm>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let navBar = navigationController?.navigationBar else { fatalError("Navigation controller does not exist.")
        }
        navBar.barTintColor = UIColor.red
    }
    
    // MARK:- Add category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var alertTextField: UITextField = UITextField()
        let alert = UIAlertController(title: K.Category.addCategory, message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: K.add, style: .default) { (action) in
            
            let newItem = CategoryRealm()
            newItem.name = alertTextField.text!
            newItem.backgroundColor = UIColor.randomFlat().hexValue()
            
            self.saveData(category: newItem)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = K.Category.addCategory
            alertTextField = textField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            cell.textLabel?.text = category.name
            let color = UIColor(hexString: category.backgroundColor) ?? FlatBlue()
            cell.backgroundColor = color
            cell.textLabel?.textColor = ContrastColorOf(color, returnFlat: true)
        } else {
            cell.textLabel?.text = K.Category.noCategories
        }
        
        return cell
    }
    
    // MARK:- Data manipulation methods
    
    func saveData(category: CategoryRealm) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
    }
    
    func loadData() {
        categories = realm.objects(CategoryRealm.self)
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        if let category = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(category)
                }
            } catch {
                print(error)
            }
        }
    }
    
    // MARK:- Table view delegates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.segue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoTableViewControllerRealm
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    
}

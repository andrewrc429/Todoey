//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Castillo on 8/19/19.
//  Copyright © 2019 Andrew Castillo. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    @IBAction func addItemButton(_ sender: UIBarButtonItem) {
        
        var tempTextField = UITextField()
        
        let textAlert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        textAlert.addTextField { (alertText) in
            alertText.placeholder = "Create New Item"
            tempTextField = alertText
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //Add Item to Todo List
            self.itemArray.append(tempTextField.text!)
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        textAlert.addAction(action)
        
        present(textAlert, animated: true)
        
        
        
    }
    
}


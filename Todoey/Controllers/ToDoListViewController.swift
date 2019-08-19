//
//  ViewController.swift
//  Todoey
//
//  Created by Andrew Castillo on 8/19/19.
//  Copyright © 2019 Andrew Castillo. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
        
    }
    
    //MARK - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        
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
            
            let newItem = Item()
            newItem.title = tempTextField.text!
            self.itemArray.append(newItem)
            
            //self.itemArray.append(tempTextField.text!)
            self.tableView.reloadData()
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        textAlert.addAction(action)
        
        present(textAlert, animated: true)
        
        
        
    }
    
}


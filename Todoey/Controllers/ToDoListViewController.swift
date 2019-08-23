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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadItems()
        
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
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
            
            self.saveItems()
            
        }
        
        textAlert.addAction(action)
        
        present(textAlert, animated: true)
        
        
        
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Could not encode data.")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Couldn't decode data. Error \(error)")
            }
        }
    }
    
}


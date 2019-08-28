//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Andrew Castillo on 8/28/19.
//  Copyright © 2019 Andrew Castillo. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    //MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error loading data from context: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var tempTextField = UITextField()
        
        let textAlert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        textAlert.addTextField { (alertText) in
            alertText.placeholder = "Create New Category"
            tempTextField = alertText
        }
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = tempTextField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
            
        }
        
        textAlert.addAction(action)
        
        present(textAlert, animated: true)
    }
    
    //MARK: - Tableview Delegate Methods
    
    
    
    
    
}

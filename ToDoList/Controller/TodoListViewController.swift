//
//  ViewController.swift
//  ToDoList
//
//  Created by Karthik Balakumar on 17/03/19.
//  Copyright © 2019 WE Apps. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let todoListArray = "todoListItemArray"
    
    var defaults = UserDefaults.standard

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if let newObjectItem = defaults.array(forKey: todoListArray) as? [Item] {
            
            itemArray = newObjectItem
            
        }
        
    
    }
    
    //MARK - Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To DO Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add to List", style: .default) { (action) in
            
            let newObjectItemInClosure = Item()
            
            newObjectItemInClosure.title = textField.text!
            
            self.itemArray.append(newObjectItemInClosure)
            
            self.defaults.set(self.itemArray, forKey: self.todoListArray)
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enter New To Do Item here"
            
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    

}


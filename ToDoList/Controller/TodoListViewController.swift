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
    
    var dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
    
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To DO Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add to List", style: .default) { (action) in
            
            let newObjectItemInClosure = Item()
            
            newObjectItemInClosure.title = textField.text!
            
            self.itemArray.append(newObjectItemInClosure)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Enter New To Do Item here"
            
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems() {
        
        do {
            let data = try PropertyListEncoder().encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error while saving \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems() {
        
        do {
            if let data = try? Data(contentsOf: dataFilePath!) {
                itemArray = try PropertyListDecoder().decode([Item].self, from: data)
            }
        } catch {
            print("error while saving \(error)")
        }
        
        tableView.reloadData()
        
    }
    

}


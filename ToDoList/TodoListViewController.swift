//
//  ViewController.swift
//  ToDoList
//
//  Created by Karthik Balakumar on 17/03/19.
//  Copyright © 2019 WE Apps. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    //MARK - Table View Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To DO Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add to List", style: .default) { (action) in
            
            self.itemArray.append(textField.text!)
            
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


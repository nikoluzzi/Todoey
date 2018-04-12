//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas on 11/04/2018.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Yoga","Méditation", "Écrire"]
    var doneArray = [String]()
    var selected : Int = 0
    
    @IBOutlet weak var labelList: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.labelList.text? = ""

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            selected = selected - 1
            self.labelList.text? = "Last checked: " + doneArray[doneArray.count-1]
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            doneArray.append(itemArray[indexPath.row])
            self.labelList.text? = "Last checked: " + itemArray[indexPath.row]
            selected = selected + 1
        }
        print (self.doneArray)
        print (selected)
    }
    
    
    // MARK - Add New items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will open once the user clicks
            self.itemArray.append(textField.text ?? "New Item")
            self.tableView.reloadData()
        
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
}


//
//  ViewController.swift
//  Todoey
//
//  Created by Nicholas on 11/04/2018.
//  Copyright © 2018 Nicholas. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    var doneArray = [String]()
    var selected : Int = 0
    
    @IBOutlet weak var labelList: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelList.text? = ""
        
        let newItem = Item(context: self.context)
        newItem.title = "Yoga"
        newItem.done = false
        itemArray.append(newItem)
        
//        let newItem2 = Item()
//        newItem2.title = "Méditation"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Écrire"
//        itemArray.append(newItem3)
        
        
       // loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        
        
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
        
        
    }
    
    
    // MARK - Add New items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will open once the user clicks
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            self.itemArray.append(newItem)
            self.saveItems()

            
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
            
            
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK - Model Manipulation Methods
    
    
    func saveItems() {
       
        do {
            
            try self.context.save()
            
        }
            catch {
                print("Error saving context \(error)")
            
        }
        
    }
//    func loadItems () {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//           let decoder = PropertyListDecoder()
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print("Error decoding : \(error)")
//            }
//        }
//
//
//    }
    
    
    
    
}


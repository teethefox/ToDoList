//
//  ViewController.swift
//  ToDoList
//
//  Created by Tiffani Fox on 11/14/17.
//  Copyright © 2017 Tiffani Fox. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var todoItems = [ToDoList]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllTodoItems()
    }
    
    @IBAction func newItemCreated(_ segue: UIStoryboardSegue) {
        
        let controller = segue.source as! AddItemViewController
        let todoItem = NSEntityDescription.insertNewObject(forEntityName: "ToDoList", into: moc) as! ToDoList
        
        todoItem.text = controller.textl.text
        todoItem.text2 = controller.text2l.text
        todoItem.date = controller.datel.date as Date?
        todoItem.check = false
        
        saveManagedObjectContext()
        
        todoItems.append(todoItem)
        tableView.reloadData()
    }
    
    func fetchAllTodoItems() {
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoList")
            self.todoItems = try moc.fetch(request) as! [ToDoList]
        } catch {
            print(error)
        }
    }
    
    func saveManagedObjectContext() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return todoItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TodoItemTableViewCell
        let todoItem = todoItems[indexPath.row]
        cell.textl.text = todoItem.text
        cell.text2l.text = todoItem.text2
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.string(from: todoItem.date as! Date)
        cell.datel.text = date
        
        if todoItem.check {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let todoItem = self.todoItems[indexPath.row]
        todoItem.check = !todoItem.check
        saveManagedObjectContext()
        
        let cell = tableView.cellForRow(at: indexPath)
        if todoItem.check {
            cell?.accessoryType = .checkmark
        } else {
            cell?.accessoryType = .none
        }
        
    }
    
}




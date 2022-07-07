//
//  ToDoDetailsViewController.swift
//  ToDoListUpdated
//
//  Created by Tetiana Borysova on 05.07.22.
//

import UIKit

class ToDoDetailsViewController: UIViewController {
    
    var toDoCD : ToDoCD? = nil
    
    @IBOutlet weak var toDoLabel: UILabel!
    
    @IBAction func doneTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as?
                          AppDelegate)?.persistentContainer.viewContext { if let toDo = toDoCD{
                              context.delete(toDo) }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext() }
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let toDo = toDoCD {
            if toDo.priority == 1{
                if let name = toDo.name{
                    toDoLabel.text = "🧐 Wichtig ❗️" + name }
            }
            else if toDo.priority == 2{
                if let name = toDo.name{
                    toDoLabel.text = " 🤓 Sehr Wichtig ❗️❗️  " + name
                }
            }else{
                if let name = toDo.name{
                    toDoLabel.text = name }
            }
        }
    }
}

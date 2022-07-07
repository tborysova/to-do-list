//
//  ToDoTableViewController.swift
//  ToDoListUpdated
//
//  Created by Tetiana Borysova on 05.07.22.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var toDoCDs: [ToDoCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }
    
    func getToDos(){
        if let context = (UIApplication.shared.delegate as?
                          AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()){
                if let toDos = toDosFromCoreData as? [ToDoCD]{
                    toDoCDs = toDos
                    tableView.reloadData() }
            }
            
        }
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoCDs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        //let selectedToDo = toDos[indexPath.row]
        
        let selectedToDo = toDoCDs[indexPath.row]
        
        if selectedToDo.priority == 1{
            if let name = selectedToDo.name{
                cell.textLabel?.text = "🧐 Wichtig ❗️" + name
            }
        }
        else if selectedToDo.priority == 2{
            if let name = selectedToDo.name{
                cell.textLabel?.text = "🤓 Sehr Wichtig ❗️❗️" + name
            }
        }
        else{
            if let name = selectedToDo.name{
                cell.textLabel?.text = name
            }
        }
        if let data = selectedToDo.image{
            cell.imageView?.image = UIImage(data:data)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCDs[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit
                            editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                let selectedToDo = toDoCDs[indexPath.row]
                context.delete(selectedToDo)
                (UIApplication.shared.delegate as?
                 AppDelegate)?.saveContext()
                getToDos()
                
            }
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addToDoViewController = segue.destination as? AddToDoViewController{
            addToDoViewController.toDoTableViewController = self
        }
        
        if let detailsToDoViewController = segue.destination as? ToDoDetailsViewController{
            if let selectedToDo = sender as? ToDoCD{
                detailsToDoViewController.toDoCD = selectedToDo }
        }
    }
}

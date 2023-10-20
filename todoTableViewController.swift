//
//  todoTableViewController.swift
//  Lab6_ToDo_List
//
//  Created by Shaik Mathar Syed on 17/10/23.
//

import UIKit

struct toDo {
    var tasks = [String]()
}

class todoTableViewController: UITableViewController {

    var toDos = toDo()

    //var toDos: [String] = []
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        if !self.defaults.bool(forKey: "setup") {
            self.defaults.set(true, forKey: "setup")
            self.defaults.set(0, forKey: "count")
        }
        else {
            toDos.tasks = defaults.value(forKey: "TaskList") as! [String]
        }


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDos.tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        cell.textLabel?.text = toDos.tasks[indexPath.row]
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.beginUpdates()
            self.toDos.tasks.remove(at: indexPath.row)
            defaults.set(self.toDos.tasks.count-1, forKey: "count")
            defaults.set(self.toDos.tasks, forKey: "TaskList")
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addItemButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            self.toDos.tasks.append(firstTextField.text!)
            var itemsCount = self.defaults.value(forKey: "count") as! Int
            itemsCount += 1
            self.defaults.set(itemsCount, forKey: "count")
            self.defaults.set(self.toDos.tasks, forKey: "TaskList")
            self.tableView.reloadData()
            })

        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                (action : UIAlertAction!) -> Void in })

        alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "Write an Item"
            }

            alertController.addAction(cancelAction)
            alertController.addAction(OKAction)

        self.present(alertController, animated: true, completion: nil)

    }
}

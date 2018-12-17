//
//  InfoTableViewController.swift
//  sqliteTestApp
//
//  Created by Mac on 17/12/18.
//  Copyright © 2018 tops. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {

    
    var ContactList = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ContactList = dbManager.shared.runQuery("select * from infoMaster order by id desc")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        ContactList = dbManager.shared.runQuery("select * from infoMaster order by id desc")
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ContactList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath)

        // Configure the cell...

        cell.textLabel?.text = ContactList[indexPath.row]["name"] as? String
        cell.detailTextLabel?.text = ContactList[indexPath.row]["emailid"] as? String
        
        return cell
    }
    var row = [String:Any]()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        row = ContactList[indexPath.row]
        self.performSegue(withIdentifier: "editSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" && row["id"] != nil{
            let destinationController = segue.destination as! ViewController
            destinationController.editRecord = row
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let id = ContactList[indexPath.row]["id"]
            if dbManager.shared.runCommand("delete from infoMaster where id = \(id!)") == true
            {
                ContactList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            
            }
        
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

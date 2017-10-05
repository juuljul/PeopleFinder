//
//  MesContactsTableViewController.swift
//  PeopleNetwork
//
//  Created by Julien Bremeersch on 04/10/2017.
//  Copyright © 2017 Julien Jul. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class MesContactsTableViewController: UITableViewController {
    
    
    var people: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath) as! PersonneTableViewCell

        let monContact = people[indexPath.row]
        guard let monContactFirstName = monContact.value(forKey: "first") as? String else{
            return cell
        }
        cell.firstNameLabel.text = monContactFirstName
        
        guard let monContactLastName = monContact.value(forKey: "last") as? String else{
            return cell
        }
        cell.lastNameLabel.text = monContactLastName
        
        guard let monContactMediumImageUrl = monContact.value(forKey: "mediumpictureUrl") as? String else{
            return cell
        }
        
        Alamofire.request(monContactMediumImageUrl).response { response in
            if let data = response.data {
                let image = UIImage(data: data)
                cell.profilImageView.image = image
            } else {
                print("Data is nil. I don't know what to do :(")
            }
        }
        
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowContact",
            let controller = segue.destination as? ContactDetailViewController,
            let tableViewCell = sender as? UITableViewCell,
            let selectedPersonneIndex = tableView.indexPath(for: tableViewCell)?.row {
            controller.personneObject = people[selectedPersonneIndex]
        }
        
        }
}
    

   
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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



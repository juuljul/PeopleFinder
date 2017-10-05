//
//  PersonnesTableViewController.swift
//  PeopleNetwork
//
//  Created by Julien Bremeersch on 29/09/2017.
//  Copyright © 2017 Julien Jul. All rights reserved.
//

import UIKit
import Alamofire

class PersonnesTableViewController: UITableViewController {
    
    var personnes: [Person] = []
//    var personnes: [Person]!
    
    let tenPersonsUrl: String = "https://api.randomuser.me/?results=10&nat=en"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        navigationItem.rightBarButtonItem = searchButton
        
        refreshContacts()
        
    }
    
    @objc func search() {
        
        let alert = UIAlertController(title: "Nouveaux contacts", message: "Voulez-vous charger 10 nouveaux contacts ? Vous perdrez les 10 contacts actuels", preferredStyle: .alert)
        
        let refreshAction = UIAlertAction(title: "Valider", style: .default) { [unowned self]
            action in
            
        self.refreshContacts()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default)
        
        alert.addAction(refreshAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func refreshContacts(){
        personnes.removeAll()
        
        Alamofire.request(tenPersonsUrl)
            .validate()
            .responseString { response in
                print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
                print("Response JSON: \(response.result.value)")
                
                guard let dictionary = response.result.value as? [String:Any],
                    let results = dictionary["results"] as? [[String:Any]] else{
                        return
                }
                for result in results{
                    guard let registered = result["registered"] as? String,
                        let email = result["email"] as? String,
                        let pictureArray = result["picture"] as? [String:Any],
                        let location = result["location"] as? [String:Any],
                        let name = result["name"] as? [String:Any]
                        else{
                            return
                    }
                    guard let mediumpictureUrl = pictureArray["medium"] as? String,
                        let largepictureUrl = pictureArray["large"] as? String
                        else{
                            return
                    }
                    guard let first = name["first"] as? String,
                        let last = name["last"] as? String else{
                            return
                    }
                    guard let street = location["street"] as? String,
                        let city = location["city"] as? String,
                        let state = location["state"] as? String else {
                            return
                    }
                    
                    let person = Person(registered: registered, email: email, largepictureUrl: largepictureUrl, mediumpictureUrl: mediumpictureUrl, first: first, last: last, street: street, city: city, state: state)
                    self.personnes.append(person)
                }
                self.tableView.reloadData()
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personnes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personnesCell", for: indexPath) as! PersonneTableViewCell
       
        cell.lastNameLabel.text = personnes[indexPath.row].last
        cell.firstNameLabel.text = personnes[indexPath.row].first
        
        Alamofire.request(personnes[indexPath.row].mediumpictureUrl).response { response in
            if let data = response.data {
                let image = UIImage(data: data)
                cell.profilImageView.image = image
            } else {
                print("Data is nil. I don't know what to do :(")
            }
        }
    
        return cell
    }
    
    
//    MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPersonne",
                    let controller = segue.destination as? PersonneDetailViewController,
                    let tableViewCell = sender as? UITableViewCell,
                    let selectedPersonneIndex = tableView.indexPath(for: tableViewCell)?.row {
                    let personne = personnes[selectedPersonneIndex]
                    controller.personne = personne
//                    controller.delegate = self
                }
    }

}

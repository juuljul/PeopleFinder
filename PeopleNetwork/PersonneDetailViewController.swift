//
//  PersonneDetailViewController.swift
//  PeopleNetwork
//
//  Created by Julien Bremeersch on 02/10/2017.
//  Copyright © 2017 Julien Jul. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class PersonneDetailViewController: UIViewController {
    
    var personne: Person!
    var people: [NSManagedObject] = []
    
    @IBOutlet weak var largePictureImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    @IBOutlet weak var streetLabel: UILabel!

    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var registeredLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let ajouterContactButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ajouterContact))
        navigationItem.rightBarButtonItem = ajouterContactButton
        
        Alamofire.request(personne.largepictureUrl).response { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.largePictureImageView.image = image
            } else {
                print("Data is nil")
            }
        }
        
        firstNameLabel.text = "Prénom:  \(personne.first)"
        lastNameLabel.text = "Nom:  \(personne.last)"
        streetLabel.text = "Rue:  \(personne.street)"
        cityLabel.text = "Ville:  \(personne.city)"
        stateLabel.text = "Etat:  \(personne.state)"
        registeredLabel.text = "Contact enregistré le \(personne.registered)"
    }
    
    func ajouterContact(){
        let alert = UIAlertController(title: "Nouveau Contact",
                                      message: "Voulez-vous ajouter cette personne dans votre liste de contacts ? ",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Ajouter", style: .default) { [unowned self] action in
            
            self.save(personneAsauver: self.personne)
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Contact")
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    func save(personneAsauver: Person) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Contact",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(personneAsauver.first, forKeyPath: "first")
        person.setValue(personneAsauver.last, forKey: "last")
        person.setValue(personneAsauver.mediumpictureUrl, forKey: "mediumpictureUrl")
        person.setValue(personneAsauver.largepictureUrl, forKey: "largepictureUrl")
        person.setValue(personneAsauver.registered, forKeyPath: "registered")
        person.setValue(personneAsauver.street, forKeyPath: "street")
        person.setValue(personneAsauver.city, forKeyPath: "city")
        person.setValue(personneAsauver.state, forKeyPath: "state")
        
        
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
     // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMesContacts"{
            if let controller = segue.destination as? MesContactsTableViewController{
                controller.people = self.people
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

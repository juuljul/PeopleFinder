//
//  ContactDetailViewController.swift
//  PeopleNetwork
//
//  Created by Julien Bremeersch on 04/10/2017.
//  Copyright © 2017 Julien Jul. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ContactDetailViewController: UIViewController {
    
    var personneObject: NSManagedObject!
    
    @IBOutlet weak var largePictureImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
    
    @IBOutlet weak var lastNameLabel: UILabel!
    
    
    @IBOutlet weak var streetLabel: UILabel!
    
    
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var stateLabel: UILabel!
    
    
    
    @IBOutlet weak var registeredLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let first = personneObject.value(forKey: "first") as? String,
            let last = personneObject.value(forKey: "last") as? String,
            let registered = personneObject.value(forKey: "registered") as? String,
            let street = personneObject.value(forKey: "street")as? String,
            let city = personneObject.value(forKey: "city")as? String,
            let state = personneObject.value(forKey: "state")as? String,
            let largepictureUrl = personneObject.value(forKey: "largepictureUrl")as? String
            else {
                return
        }
        
        Alamofire.request(largepictureUrl).response { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.largePictureImageView.image = image
            } else {
                print("Data is nil")
            }
        }
        
        
        firstNameLabel.text = "Prénom:  \(first)"
        lastNameLabel.text = "Nom:  \(last)"
        streetLabel.text = "Rue:  \(street)"
        cityLabel.text = "Ville:  \(city)"
        stateLabel.text = "Etat:  \(state)"
        registeredLabel.text = "Contact enregistré le \(registered)"
        

        // Do any additional setup after loading the view.
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  DetailViewController.swift
//  PeopleNetwork
//
//  Created by Julien Bremeersch on 05/10/2017.
//  Copyright © 2017 Julien Jul. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class DetailViewController: PersonneDetailViewController {
    
    
    var personneObject: NSManagedObject!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        saveButton.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let first = personneObject.value(forKey: "first") as? String,
            let last = personneObject.value(forKey: "last") as? String,
            let email = personneObject.value(forKey: "email") as? String,
            let registered = personneObject.value(forKey: "registered") as? String,
            let street = personneObject.value(forKey: "street")as? String,
            let city = personneObject.value(forKey: "city")as? String,
            let state = personneObject.value(forKey: "state")as? String,
            let largepictureUrl = personneObject.value(forKey: "largepictureUrl")as? String,
            let mediumpictureUrl = personneObject.value(forKey: "mediumpictureUrl")as? String else {
                return
        }
        
        personne = Person(registered: registered, email: email, largepictureUrl: largepictureUrl, mediumpictureUrl: mediumpictureUrl, first: first, last: last, street: street, city: city, state: state)
        

        
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

//
//  userProfileVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class userProfileVC: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtContactNumber: UITextField!
    @IBOutlet var txtCarPlateNumber: UITextField!
    @IBOutlet var txtCity: UITextField!
    
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Edit"
        //Adding button to navigation menu
        let btnEdit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(nextScreen))
        navigationItem.rightBarButtonItem = btnEdit
    }
     @objc private func nextScreen(){
        let userProfileEditSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let userProfileEditVC = userProfileEditSB.instantiateViewController(withIdentifier: "userProfileEditScreen")
        navigationController?.pushViewController(userProfileEditVC, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let car_number = value?["car_number"] as? String ?? ""
            let city = value?["city"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let number = value?["number"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            
            
            self.txtEmail.text = email
            self.txtCarPlateNumber.text = car_number
            self.txtCity.text = city
            self.txtName.text = name
            self.txtContactNumber.text = number
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

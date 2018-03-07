//
//  userProfileEditVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class userProfileEditVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtCarPlateNumber: UITextField!
    @IBOutlet var txtContactNumber: UITextField!
    @IBOutlet var cityPicker: UIPickerView!
    
    var email : String = ""
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    
    var cityList: [String] = ["Vancouver", "Ottawa", "Toronto", "Calgary", "Windsor", "Ajax", "Pickering","Brampton", "Mississauga", "NorthYork", "Scarborough"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.cityPicker.dataSource = self
        self.cityPicker.delegate = self
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let car_number = value?["car_number"] as? String ?? ""
            let city = value?["city"] as? String ?? ""
            let name = value?["name"] as? String ?? ""
            let number = value?["number"] as? String ?? ""
            self.email = value?["email"] as? String ?? ""
            
            let cityIndex = Int((self.cityList.index(of: city)?.description)!)
            self.cityPicker.selectRow(cityIndex!, inComponent: 0, animated: false)
            //self.cityPicker.selectedRow(inComponent: cityIndex!)
            
            self.txtCarPlateNumber.text = car_number
            self.txtName.text = name
            self.txtContactNumber.text = number
            
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Edit"
        let btnSave = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(updateData))
        navigationItem.rightBarButtonItem = btnSave
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateData(){
        
        //This get's the user's id i.e. $userID
        let userID = Auth.auth().currentUser?.uid
        //userRef is reference to the /users/$userID
        let userRef = self.ref.child("users").child(userID!)
        
        let selectedCityIndex = self.cityPicker.selectedRow(inComponent: 0)
        let dataToUpdate = ["name"
            : self.txtName.text!, "number" : self.txtContactNumber.text!, "city" : self.cityList[selectedCityIndex], "car_number" : self.txtCarPlateNumber.text!, "email" : self.email]
        
        //This line below adds the data of the user
        let childUpdates = ["/users/\(userID!)": dataToUpdate]
        ref.updateChildValues(childUpdates)
        
        
        let alert = UIAlertController(title: "Update", message: "User details updated", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.moveToHomeScreen()}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func moveToHomeScreen() {
        let homeSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = homeSB.instantiateViewController(withIdentifier: "homeScreen")
        navigationController?.pushViewController(homeVC, animated: true)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cityList[row]
    }

}

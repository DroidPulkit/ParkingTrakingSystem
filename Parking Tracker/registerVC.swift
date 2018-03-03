//
//  registerVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-02-21.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class registerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    //This is the list for the picker
    var cityList: [String] = ["Vancouver", "Ottawa", "Toronto", "Calgary", "Windsor", "Ajax", "Pickering","Brampton", "Mississauga", "NorthYork", "Scarborough"]
    var selectedCityIndex: Int = 0
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    
    
    

    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Register"
        //Adding button to navigation menu
        let btnSubmit = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(displayValues))
        
        self.navigationItem.rightBarButtonItem = btnSubmit
        //Making the title white
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        //This makes the back button white
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.cityList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.cityList[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        //add data in picker
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = cityList[row]
        //Adding title to the pickerview and then adding attributes like making it white and adding custom font to it.
        return NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontNames(forFamilyName: "Chalkboard SE")])
    }
    

    @objc private func displayValues(){
        self.selectedCityIndex = self.cityPicker.selectedRow(inComponent: 0)
        
        //Extracting values
        let name = self.txtName.text!
        let email = self.txtEmail.text!
        let pass = self.txtPassword.text!
        let number = self.txtContactNumber.text!
        let city = self.cityList[selectedCityIndex]
        let carNo = self.txtCarPlateNumber.text!
        
        let allData: String = "\(name) \n \(email) \n \(pass) \n \(number) \n \(city) \n \(carNo)"
        
        //Validating the data
        if (name.isEmpty || email.isEmpty || pass.isEmpty || number.isEmpty || city.isEmpty || carNo.isEmpty){
            let infoAlert = UIAlertController(title: "Error", message: "Fields cannot be empty", preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Try Again", style: .destructive, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
            return
        } else if (number.count != 10){
            let infoAlert = UIAlertController(title: "Error", message: "Contact number is not of 10 digits", preferredStyle: .alert)
            infoAlert.addAction(UIAlertAction(title: "Try Again", style: .destructive, handler: nil))
            self.present(infoAlert, animated: true, completion: nil)
            return
        }
        
        //Action Sheet
        let infoAlert = UIAlertController(title: "Verify your details", message: allData, preferredStyle: .actionSheet)
        infoAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        infoAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in self.register()}))
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    //Using firebase to register the data
    func register() {
        //registering the user
        Auth.auth().createUser(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            //This will work if there is some error, basically error handling by firebase
            if let error = error {
                let infoAlert = UIAlertController(title: "Error", message: String(error.localizedDescription), preferredStyle: .alert)
                infoAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(infoAlert, animated: true, completion: nil)
                return
            }
            //If no error by firebase then this below will work
            let alert = UIAlertController(title: "Registeration", message: "User registered", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in self.saveToDatabase()}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func saveToDatabase() {
        //This get's the user's id i.e. $userID
        let userID = Auth.auth().currentUser?.uid
        //userRef is reference to the /users/$userID
        let userRef = self.ref.child("users").child(userID!)
        //This line below adds the data of the user
        userRef.setValue(["name" : self.txtName.text!, "number" : self.txtContactNumber.text!, "city" : self.cityList[selectedCityIndex], "car_number" : txtCarPlateNumber.text! ])
        self.backScreen()
    }
    //Back screen
    func backScreen() {
        self.navigationController?.popViewController(animated: true)
    }
}

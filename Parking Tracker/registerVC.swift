//
//  registerVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-02-21.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit

class registerVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtCarPlateNumber: UITextField!
    @IBOutlet weak var cityPicker: UIPickerView!
    
    var cityList: [String] = ["Vancouver", "Ottawa", "Toronto", "Calgary", "Windsor", "Ajax", "Pickering","Brampton", "Mississauga", "NorthYork", "Scarborough"]
    var selectedCityIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Register"
        
        let btnSubmit = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(displayValues))
        
        self.navigationItem.rightBarButtonItem = btnSubmit
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = cityList[row]
        return NSAttributedString(string: titleData, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.fontNames(forFamilyName: "Chalkboard SE")])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //add data in picker
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc private func displayValues(){
        self.selectedCityIndex = self.cityPicker.selectedRow(inComponent: 0)
        
        let allData: String = "\(self.txtName.text!) \n \(self.txtEmail.text!) \n \(self.txtPassword.text) \n \(self.txtContactNumber.text!) \n \(self.cityList[selectedCityIndex]) \n \(self.txtCarPlateNumber.text!)"
        
        //Action Sheet
        let infoAlert = UIAlertController(title: "Verify your details", message: allData, preferredStyle: .actionSheet)
        
        infoAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        infoAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        self.present(infoAlert, animated: true, completion: nil)
    }

}

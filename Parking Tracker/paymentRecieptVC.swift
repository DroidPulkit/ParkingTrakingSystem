//
//  paymentRecieptVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class paymentRecieptVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblCarPlateNumber: UILabel!
    @IBOutlet weak var carCompanyPicker: UIPickerView!
    
    @IBOutlet weak var carLogo: UIImageView!
    
    @IBOutlet weak var carColorPicker: UIPickerView!
    
    @IBOutlet weak var noOfHoursStepper: UIStepper!
    
    @IBOutlet weak var lblStepperValue: UILabel!
    
    @IBOutlet weak var dateTime: UIDatePicker!
    
    @IBOutlet weak var txtLotNo: UITextField!
    @IBOutlet weak var txtSpotNo: UITextField!
    
    @IBOutlet weak var paymentMethodPicker: UIPickerView!
    @IBOutlet weak var payementLogo: UIImageView!
    
    
    @IBOutlet weak var lblPaymentAmount: UILabel!
    
    @IBAction func myStepperAction(_ sender: UIStepper) {
        lblStepperValue.text = String(noOfHoursStepper.value)
        lblPaymentAmount.text = "$" + String(noOfHoursStepper.value * 4)
    }
    var companyList : [String] = ["BMW", "Audi", "Hyundai", "Ferrari", "Lexus"]
    
    var carLogoImages : [UIImage] = [UIImage(named: "BMW.jpg")!, UIImage(named: "Audi.jpg")!, UIImage(named: "Hyundai.jpg")!, UIImage(named: "Ferrari.jpg")!, UIImage(named: "Lexus.jpg")!]
    
    var carColorList : [String] = ["Red", "Black", "Grey", "White", "Blue", "Yellow"]
    
    var paymentMethods : [String] = ["Visa", "Visa Debit", "Mastercard"]
    
    var paymentMethodsImages : [UIImage] = [UIImage(named: "Visa.jpg")!, UIImage(named: "Visa_debit.png")!, UIImage(named: "mastercard.png")!]
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carColorPicker.dataSource = self
        self.carColorPicker.delegate = self
        
        self.carCompanyPicker.dataSource = self
        self.carCompanyPicker.delegate = self
        
        self.paymentMethodPicker.dataSource = self
        self.paymentMethodPicker.delegate = self
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let carplate = value?["car_number"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            self.lblCarPlateNumber.text = carplate
            self.lblEmail.text = email
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return companyList.count
        } else if(pickerView.tag == 2) {
            return carColorList.count
        } else {
            return paymentMethods.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return companyList[row]
        } else if(pickerView.tag == 2) {
            return carColorList[row]
        } else {
            return paymentMethods[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            carLogo.image = carLogoImages[row]
        }
        if(pickerView.tag == 3) {
            payementLogo.image = paymentMethodsImages[row]        }
    }
    
    
    @IBAction func btnSave(_ sender: UIButton) {
        
        let email = self.lblEmail.text!
        let carNo = self.lblCarPlateNumber.text!
        let indexOfCarCompany = self.carCompanyPicker.selectedRow(inComponent: 0)
        let carCompany = self.companyList[indexOfCarCompany]
        let indexOfCarColor = self.carColorPicker.selectedRow(inComponent: 0)
        let carColor = self.carColorList[indexOfCarColor]
        let noOfHours = lblStepperValue.text!
        let dateTime = self.dateTime.date
        let lotNo = self.txtLotNo.text!
        let spotNo = self.txtSpotNo.text!
        let indexOfPaymentMethod = self.paymentMethodPicker.selectedRow(inComponent: 0)
        let paymentMethod = self.paymentMethods[indexOfPaymentMethod]
        let paymentAmount = self.lblPaymentAmount.text!
        
        
        let allData: String = "\(email) \n \(carNo) \n \(carCompany) \n \(carColor) \n \(noOfHours) \n \(dateTime) \n \(lotNo) \n \(spotNo) \n \(paymentMethod) \n \(paymentAmount)"
        
        
        let infoAlert = UIAlertController(title: "Verify your details", message: allData, preferredStyle: .actionSheet)
        infoAlert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        infoAlert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in self.saveToDatabase()}))
        self.present(infoAlert, animated: true, completion: nil)
        
    }
    
    func saveToDatabase() {
        //Just getting data in var
        let email = self.lblEmail.text!
        let carNo = self.lblCarPlateNumber.text!
        let indexOfCarCompany = self.carCompanyPicker.selectedRow(inComponent: 0)
        let carCompany = self.companyList[indexOfCarCompany]
        let indexOfCarColor = self.carColorPicker.selectedRow(inComponent: 0)
        let carColor = self.carColorList[indexOfCarColor]
        let noOfHours = lblStepperValue.text!
        let dateTime: String = String(describing: self.dateTime.date)
        let lotNo = self.txtLotNo.text!
        let spotNo = self.txtSpotNo.text!
        let indexOfPaymentMethod = self.paymentMethodPicker.selectedRow(inComponent: 0)
        let paymentMethod = self.paymentMethods[indexOfPaymentMethod]
        let paymentAmount = self.lblPaymentAmount.text!
        
        
        
        //This get's the user's id i.e. $userID
        let userID = Auth.auth().currentUser?.uid
        //userRef is reference to the /users/$userID
        let parkingReceiptRef = self.ref.child("parkingReceipt").child(userID!)
        //This line below adds the data of the user
        parkingReceiptRef.setValue(["email" : email, "carNo" : carNo, "carCompany" : carCompany, "carColor" : carColor, "noOfHours" : noOfHours, "dateTime" : dateTime, "lotNo" : lotNo, "spotNo" : spotNo, "paymentMethod" : paymentMethod, "paymentAmount" : paymentAmount])
        self.nextScreen()
    }
    
    func nextScreen() {
        let parkingReceiptDetailSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let parkingReceiptDetailVC = parkingReceiptDetailSB.instantiateViewController(withIdentifier: "ParkingReceiptDetail")
        navigationController?.pushViewController(parkingReceiptDetailVC, animated: true)
    }
    

}

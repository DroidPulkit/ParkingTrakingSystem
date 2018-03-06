//
//  parkingReceiptDetailVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class parkingReceiptDetailVC: UIViewController {

    @IBOutlet var lblEmail: UILabel!
    @IBOutlet var lblCarPlateNumber: UILabel!
    @IBOutlet var lblCarCompanyName: UILabel!
    @IBOutlet var lblParkingHours: UILabel!
    @IBOutlet var lblCarColor: UILabel!
    @IBOutlet var lblDateTime: UILabel!
    @IBOutlet var lblLotNumber: UILabel!
    @IBOutlet var lblSpotNumber: UILabel!
    @IBOutlet var lblPaymentMethod: UILabel!
    @IBOutlet var lblPaymentAmount: UILabel!
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let userID = Auth.auth().currentUser?.uid
        //What is happening is it is giving the last child in the parkingReceipt/$userID
        ref.child("parkingReceipt").child(userID!).queryOrderedByKey().queryLimited(toLast: 1).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            
            //This loops iterates through all the children in the snapshot
            for task in snapshot.children {
                //If it finds the DataSnapshot it will move forward
                guard let taskSnapshot = task as? DataSnapshot else {
                    continue
                }
                //Here we are getting the random key, which was saved in DB, which I generated using childByAutoID()
                let id = taskSnapshot.key
                print("The key for the last data is: ")
                print(id)
                
                let value = snapshot.childSnapshot(forPath: id).value as? NSDictionary
                print(String(describing: value))
                let carColor = value?["carColor"] as? String ?? ""
                let carCompany = value?["carCompany"] as? String ?? ""
                let carNo = value?["carNo"] as? String ?? ""
                let dateTime = value?["dateTime"] as? String ?? ""
                let email = value?["email"] as? String ?? ""
                let lotNo = value?["lotNo"] as? String ?? ""
                let noOfHours = value?["noOfHours"] as? String ?? ""
                let paymentAmount = value?["paymentAmount"] as? String ?? ""
                let paymentMethod = value?["paymentMethod"] as? String ?? ""
                let spotNo = value?["spotNo"] as? String ?? ""
                self.lblEmail.text = email
                self.lblCarPlateNumber.text = carNo
                self.lblCarCompanyName.text = carCompany
                self.lblParkingHours.text = noOfHours
                self.lblCarColor.text = carColor
                self.lblDateTime.text = dateTime
                self.lblLotNumber.text = lotNo
                self.lblSpotNumber.text = spotNo
                self.lblPaymentMethod.text = paymentMethod
                self.lblPaymentAmount.text = paymentAmount
            }
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

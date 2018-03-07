//
//  ParkingReportTVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-05.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class ParkingReportTVC: UITableViewController {
    
    //Firebase stuff
    var ref: DatabaseReference = Database.database().reference()
    
    var listOfParkingReceipts: [ParkingPaymentReceipt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = 140
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background.png"))

        let userID = Auth.auth().currentUser?.uid
        //What is happening is it is giving all child in the parkingReceipt/$userID
        ref.child("parkingReceipt").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
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
                let parkingReceipt = ParkingPaymentReceipt(carColor: carColor, carCompany: carCompany, carNo: carNo, dateTime: dateTime, email: email, lotNo: lotNo, noOfHours: noOfHours, paymentAmount: paymentAmount, paymentMethod: paymentMethod, spotNo: spotNo)
                self.listOfParkingReceipts.append(parkingReceipt)
                self.tableView.reloadData()
            }
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfParkingReceipts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parkingdetailCell", for: indexPath) as! ParkingReportTVCell
        
        //Configure the cell...
        //To remove the selected cell grey background
        cell.selectionStyle = .none
        cell.lblCarNumber.text = " \(listOfParkingReceipts[indexPath.row].carNo)"
        
        
        let dateTime : String = listOfParkingReceipts[indexPath.row].dateTime
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let startDate = deFormatter.date(from: dateTime)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:MM"
        let onlyDate = formatter.string(from: startDate!)
        
        cell.lblDate.text = onlyDate
        //cell.lblDate.text = listOfParkingReceipts[indexPath.row].dateTime
        cell.lblHours.text = " \(listOfParkingReceipts[indexPath.row].noOfHours)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let parkingReceipt = listOfParkingReceipts[indexPath.row]
        let DetailParkingSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let DetailParkingVC = DetailParkingSB.instantiateViewController(withIdentifier: "DetailParkingScreen") as! DetailParkingRecieptVC
        print("printing the first parking. (if exists)")
        
        if  (listOfParkingReceipts.count > 0) {
            print(listOfParkingReceipts[0].carColor)
            print(String(describing: parkingReceipt))
            
            
            DetailParkingVC.strEmail = parkingReceipt.email
            DetailParkingVC.strCarColor = parkingReceipt.carColor
            DetailParkingVC.strCarCompanyName = parkingReceipt.carCompany
            DetailParkingVC.strCarPlateNumber = parkingReceipt.carNo
            DetailParkingVC.strDateTime = parkingReceipt.dateTime
            DetailParkingVC.strLotNumber = parkingReceipt.lotNo
            DetailParkingVC.strSpotNumber = parkingReceipt.spotNo
            DetailParkingVC.strParkingHours = parkingReceipt.noOfHours
            DetailParkingVC.strPaymentAmount = parkingReceipt.paymentAmount
            DetailParkingVC.strPaymentMethod = parkingReceipt.paymentMethod
        }
        
        self.navigationController?.pushViewController(DetailParkingVC, animated: true)
    }

}

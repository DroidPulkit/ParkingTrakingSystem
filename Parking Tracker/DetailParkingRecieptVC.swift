//
//  DetailParkingRecieptVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-05.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit

class DetailParkingRecieptVC: UIViewController {

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
    
    var strEmail : String = ""
    var strCarPlateNumber : String = ""
    var strCarCompanyName : String = ""
    var strParkingHours : String = ""
    var strCarColor : String = ""
    var strDateTime : String = ""
    var strLotNumber : String = ""
    var strSpotNumber : String = ""
    var strPaymentMethod : String = ""
    var strPaymentAmount : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblEmail.text = strEmail
        lblPaymentMethod.text = strPaymentMethod
        lblPaymentAmount.text = strPaymentAmount
        lblParkingHours.text = strParkingHours
        lblSpotNumber.text = strSpotNumber
        lblLotNumber.text = strLotNumber
        lblDateTime.text = strDateTime
        lblCarPlateNumber.text = strCarPlateNumber
        lblCarCompanyName.text = strCarCompanyName
        lblCarColor.text = strCarColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  ParkingPaymentReceipt.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-05.
//  Copyright © 2018 mad. All rights reserved.
//

import Foundation

class ParkingPaymentReceipt {
    var carColor: String
    var carCompany: String
    var carNo: String
    var dateTime: String
    var email: String
    var lotNo: String
    var noOfHours: String
    var paymentAmount: String
    var paymentMethod: String
    var spotNo: String
    
    init(){
        self.carColor = ""
        self.carCompany = ""
        self.carNo = ""
        self.dateTime = ""
        self.email = ""
        self.lotNo = ""
        self.noOfHours = ""
        self.paymentAmount = ""
        self.paymentMethod = ""
        self.spotNo = ""
    }
    
    init(carColor: String, carCompany: String, carNo: String, dateTime: String, email: String, lotNo: String, noOfHours: String, paymentAmount: String, paymentMethod: String, spotNo: String){
        self.carColor = carColor
        self.carCompany = carCompany
        self.carNo = carNo
        self.dateTime = dateTime
        self.email = email
        self.lotNo = lotNo
        self.noOfHours = noOfHours
        self.paymentAmount = paymentAmount
        self.paymentMethod = paymentMethod
        self.spotNo = spotNo
    }
    
    
}

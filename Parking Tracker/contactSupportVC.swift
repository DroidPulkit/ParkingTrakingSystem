//
//  contactSupportVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit

class contactSupportVC: UIViewController {


    @IBOutlet var phoneView: UIView!
    @IBOutlet var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(phoneTapped(tapGestureRecognizer:)))
        phoneView.addGestureRecognizer(tapPhone)
        phoneView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func phoneTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Tapped phone")
        
//        if let phoneCallURL = URL(string: "tel://4169776267") {
//            let application:UIApplication = UIApplication.shared
//            if (application.canOpenURL(phoneCallURL)) {
//                application.open(phoneCallURL, options: [:], completionHandler: nil)
//            }
//        }
        //UIApplication.shared.canOpenURL(URL(string: "tel://1234567890")!)
        //UIApplication.sharedApplication().openURL(NSURL(string: "tel://1234567890"))
    }

}

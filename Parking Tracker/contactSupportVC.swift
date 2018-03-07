//
//  contactSupportVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-04.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import CallKit
import MessageUI

class contactSupportVC: UIViewController {


    @IBOutlet var phoneView: UIView!
    @IBOutlet var emailView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(phoneTapped(tapGestureRecognizer:)))
        phoneView.addGestureRecognizer(tapPhone)
        phoneView.isUserInteractionEnabled = true
        
        let emailPhone = UITapGestureRecognizer(target: self, action: #selector(emailTapped(tapGestureRecognizer:)))
        emailView.addGestureRecognizer(emailPhone)
        emailView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func phoneTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Tapped phone")
        
        print("calling.....")
        let url = URL(string: "tel://+14169776261")
        
        if UIApplication.shared.canOpenURL(url!){
            if #available(iOS 10, *){
                UIApplication.shared.open(url!)
            } else
            {
                UIApplication.shared.openURL(url!)
            }
        }
    }
    
    @objc func emailTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        print("Tapped email")
        
        if MFMailComposeViewController.canSendMail() {
            let EmailPicker = MFMailComposeViewController()
            
            EmailPicker.mailComposeDelegate = self
            EmailPicker.setToRecipients(["support@parkme.com"])
            EmailPicker.setSubject("Test Email")
            EmailPicker.setMessageBody("Hello, how are you!", isHTML: true)
            
            self.present(EmailPicker, animated: true, completion: nil)
        } else {
            print("can't sent email....")
        }
    }

}

extension contactSupportVC: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

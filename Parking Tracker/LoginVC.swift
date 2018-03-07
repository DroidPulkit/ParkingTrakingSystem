//
//  LoginVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-02-20.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }

    
    
    
    @IBInspectable var bottomBorderColor: UIColor? {
        get {
            return self.bottomBorderColor
        }
        set {
            self.borderStyle = UITextBorderStyle.none;
            let border = CALayer()
            let width = CGFloat(0.5)
            border.borderColor = newValue?.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
            
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
            
        }
    }
}

class LoginVC: UIViewController {
    
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationItem.title = "Log In"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLoginAction(_ sender: UIButton) {
        
        let Email = txtEmail.text
        let Password = txtPassword.text
        
        
        if (Email?.isEmpty)! || (Password?.isEmpty)! {
            showError()
        }
        
        Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
            if let error = error {
                let infoAlert = UIAlertController(title: "Error", message: String(error.localizedDescription), preferredStyle: .alert)
                infoAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
                self.present(infoAlert, animated: true, completion: nil)
                return
            }
            
            self.storeLastLogin()
            
            let homeSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = homeSB.instantiateViewController(withIdentifier: "homeScreen")
            self.navigationController?.pushViewController(homeVC, animated: true)

        }
    }
    
    func storeLastLogin() {
        let date = Date()
        let formatterForDate = DateFormatter()
        
        formatterForDate.dateFormat = "dd-MM-yyyy"
        
        let dateStr = formatterForDate.string(from: date)
        
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        
        let time : String = "\(hour):\(minutes):\(seconds)"
        
        //Firebase stuff
        var ref: DatabaseReference = Database.database().reference()
        
        //This get's the user's id i.e. $userID
        let userID = Auth.auth().currentUser?.uid
        //userRef is reference to the /users/$userID
        let userRef = ref.child("users").child(userID!)
        //This line below adds the data of the user
        //var hash = ["lastloginDate" : dateStr, "lastLoginTime" : time]
        //userRef.updateChildValues([hash])
        userRef.updateChildValues(["lastLoginDate" : dateStr, "lastLoginTime" : time])
    }
    
    func showError(){
        let infoAlert = UIAlertController(title: "Error", message: "Email and password field cannot be empty", preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Try Again", style: .default, handler: nil))
        self.present(infoAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnRegisterAction(_ sender: UIButton) {
        let registerSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let registerVC = registerSB.instantiateViewController(withIdentifier: "registerScreen")
        navigationController?.pushViewController(registerVC, animated: true)
        
    }

}


//
//  HomeVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-02-23.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
//    var handle: AuthStateDidChangeListenerHandle?
//
//    override func viewWillAppear(_ animated: Bool) {
//        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
//            // ...
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        Auth.auth().removeStateDidChangeListener(handle!)
//    }

    @IBOutlet var parkingManualView: UIView!
    @IBOutlet var logoutView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapParkingManual = UITapGestureRecognizer(target: self, action: #selector(parkingTapped(tapGestureRecognizer:)))
        parkingManualView.addGestureRecognizer(tapParkingManual)
        parkingManualView.isUserInteractionEnabled = true
        
        let tapLogout = UITapGestureRecognizer(target: self, action: #selector(logoutTapped(tapGestureRecognizer:)))
        logoutView.addGestureRecognizer(tapLogout)
        logoutView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func parkingTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        //_ = tapGestureRecognizer.view as! UIView
        
        let parkingSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let parkingVC = parkingSB.instantiateViewController(withIdentifier: "parkingScreen")
        navigationController?.pushViewController(parkingVC, animated: true)
    }
    
    @objc func logoutTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            moveToFirstScreen()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }

    }
    
    func moveToFirstScreen() {
        let loginSB : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "loginScreen")
        //navigationController?.viewControllers.removeAll()
        navigationController?.pushViewController(loginVC, animated: true)
    }

}

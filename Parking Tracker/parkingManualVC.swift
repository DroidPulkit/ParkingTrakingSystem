//
//  parkingManualVC.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-02-27.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit
import WebKit

class parkingManualVC: UIViewController {

    @IBOutlet var myWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadManualPage()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background.png"), for: .default)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadManualPage() {
        let localfilePath = Bundle.main.url(forResource: "manual", withExtension: "html")
        let myRequest = NSURLRequest(url: localfilePath!)
        myWebView.load(myRequest as URLRequest)
    }

}

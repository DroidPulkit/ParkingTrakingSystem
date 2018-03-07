//
//  ParkingReportTVCell.swift
//  Parking Tracker
//
//  Created by Pulkit Kumar on 2018-03-05.
//  Copyright © 2018 mad. All rights reserved.
//

import UIKit

class ParkingReportTVCell: UITableViewCell {

    @IBOutlet var lblCarNumber: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblHours: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}


//
//  PoliceCell.swift
//  jdd-v2
//
//  Created by laurine baillet on 27/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import UIKit

class PoliceCell: UITableViewCell {
    static let identifier = "policeCell"
    
    @IBOutlet weak var policeStepper: UIStepper!
    @IBOutlet weak var examplePoliceLabel: UILabel!
    @IBOutlet weak var indexPoliceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        policeStepper.maximumValue = 5
        
    }
    
    //MARK: UIStepper Action
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        indexPoliceLabel.text = Int(sender.value).description
        
        
    }
}

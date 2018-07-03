//
//  VideCacheCell.swift
//  jdd-v2
//
//  Created by laurine baillet on 27/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import UIKit
import Kingfisher

/**
 Cell for SettingsViewController to show cache size from Kingfisher & Disk
 */
class VideCacheCell : UITableViewCell {
    static let identifier = "videCacheCell"
    
    @IBOutlet weak var estimationLabel: UILabel!
    
    /**
     Setup cell by setting cache size estimation
    */
    func setupCell() {
        KingfisherManager.shared.cache.calculateDiskCacheSize { (estim) in
            if let estimFloat = Float(estim.description) {
                let estimationInMB = estimFloat / 1000000
                
                //To debug
//                var size = DiskHelper.shared.getCacheSize()
                DispatchQueue.main.async {
                    self.estimationLabel.text = String(format: "%.2f MB", estimationInMB)
                }
            }
        }
    }
}

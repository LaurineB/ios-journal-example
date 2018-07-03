//
//  firstArticleCell.swift
//  jdd-v2
//
//  Created by laurine baillet on 27/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import UIKit
import Kingfisher

class FirstArticleCell : UICollectionViewCell {
    
    static let identifier = "firstArticleCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var titreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    //----------------------------------------------------------------------------
    
    func setup(titre: String?, hour: String?, imageURL: String?) {
        self.titreLabel.text = titre ?? ""
        self.hourLabel.text = hour ?? ""
        
        if var imgURL = imageURL {
            imgURL = Utils.urlResizeForFirstCell(path: imgURL)
            if let downloadURL = URL(string: imgURL){
                let ressource = ImageResource(downloadURL: downloadURL, cacheKey:imgURL)
                self.imageView.kf.setImage(with: ressource)
            }
        }
    }
}

//
//  ListArticlesCollectionViewCell.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListArticlesCollectionViewCell : UICollectionViewCell {
    
    static let identifier = "listArticlesCell"
    
    @IBOutlet weak var photoArticleImageView: UIImageView!
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    
    func setup(titre : String?, hour: String?, imageURL:String? = "") {
        
       
        self.titreLabel.text = titre ?? ""
        self.hourLabel.text = hour ?? ""
        
        if var imgURL = imageURL{
            imgURL = Utils.urlResizeForListArticleCell(path: imgURL)
            if let downloadURL = URL(string: imgURL){
                let ressource = ImageResource(downloadURL: downloadURL, cacheKey:imgURL)
                self.photoArticleImageView.kf.setImage(with: ressource)
            }
        }
      
    }
}

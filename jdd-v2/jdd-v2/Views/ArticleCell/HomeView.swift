//
//  HomeView.swift
//  jdd-v2
//
//  Created by laurine baillet on 25/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeView : UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titreLabel: UILabel!
    
    func setup(imageString: String, titre: String?) {

        if let imageUrl = URL(string: imageString) {
            let ressource = ImageResource(downloadURL: imageUrl, cacheKey: imageString)
            self.imageView.kf.setImage(with: ressource)
        }
        
        self.titreLabel.text = titre ?? ""
    }
}

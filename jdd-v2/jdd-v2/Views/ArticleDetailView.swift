//
//  ArticleDetailViewController.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ArticleDetailView: UIView {
    
    @IBOutlet weak var rubriqueLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var chapeauWebView: UIWebView!
    @IBOutlet weak var contenuWebView: UIWebView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //----------------------------------------------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //custom logic goes here

        self.scrollView.isScrollEnabled = true;
        self.scrollView.clipsToBounds = false;
        
    }
    //----------------------------------------------------------------------------
    
    func setupContent(rubrique: String?, date: String?, image: String?, contenu: String?, titre: String?, chapeau: String?) {
        
        self.rubriqueLabel.text = rubrique
        self.dateLabel.text = date
        self.titreLabel.text = titre
        
        if var imageString = image {
            imageString = Utils.urlResizeForArticle(path: imageString)
            if let imageUrl = URL(string: imageString) {
                let ressource = ImageResource(downloadURL: imageUrl, cacheKey: imageString)
                self.mainImageView.kf.setImage(with: ressource)
            }
        }
        
        setupChapeauWebview(with: chapeau)
        setupContenuWebview(with: contenu)
    }
    
    //----------------------------------------------------------------------------
    
    func setupChapeauWebview(with chapeau: String?) {
        self.chapeauWebView.scrollView.isScrollEnabled = false
        self.chapeauWebView.loadHTMLString(chapeau ?? "", baseURL: URL(string: urlJDD.baseUrl))
    }
    
    //----------------------------------------------------------------------------
    
    func setupContenuWebview(with contenu: String?) {
        self.contenuWebView.scrollView.isScrollEnabled = false
        self.contenuWebView.loadHTMLString(contenu ?? "", baseURL: URL(string: urlJDD.baseUrl))
    }
    
    //----------------------------------------------------------------------------
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

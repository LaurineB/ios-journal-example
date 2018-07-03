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

class ArticleDetailViewController: UIViewController {
    
    var pageIndex : Int = 0
    var article : Article? = nil
    
    @IBOutlet var backButtonBarView: UIView!
    @IBOutlet weak var chapeauWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var contenuWebViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var articleDetailView: ArticleDetailView!

    static let storyboardIdentifier = "ArticleDetailVC"
//----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleDetailView.setupContent(rubrique: article?.r, date: article?.d.dateHourStringFromInterval(), image: self.article?.i.uc, contenu: article?.dsc, titre: article?.t, chapeau: article?.itIn)

    }
//----------------------------------------------------------------------------
    // share text
    @IBAction func shareTextButton(_ sender: UIButton) {
        
        // text to share
        let text = "This is some text that I want to share."
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
extension ArticleDetailViewController : UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if(webView == articleDetailView.contenuWebView) {
            webView.frame.size.height = 1
            webView.frame.size = webView.sizeThatFits(.zero)
            webView.scrollView.isScrollEnabled = false
            let height = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
            if let height = height {
                if let heightInt = Int(height) {
                    let heightFloat = Float(heightInt)
                    
                    contenuWebViewHeightConstraint.constant = CGFloat(heightFloat)
                }
            }
            webView.scalesPageToFit = true
        } else if(webView == articleDetailView.chapeauWebView){
            webView.frame.size.height = 1
            webView.frame.size = webView.sizeThatFits(.zero)
            webView.scrollView.isScrollEnabled = false
            let height = webView.stringByEvaluatingJavaScript(from: "document.body.scrollHeight")
            if let height = height {
                if let heightInt = Int(height) {
                    let heightFloat = Float(heightInt)
                    
                    chapeauWebViewHeightConstraint.constant = CGFloat(heightFloat)
                }
            }
            webView.scalesPageToFit = true
        }
    }
    //----------------------------------------------------------------------------
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if(navigationType == .linkClicked) {

            return false
        }
        return true
    }
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
extension String {
    func dateHourStringFromInterval() -> String {
        let interval : Int = Int(self)!
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(interval))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        
        return dateFormatter.string(from: date)
    }
}

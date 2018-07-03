//
//  SwipeArticleCollectionViewController.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit

class PagerArticles: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet var backBarButtonView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    
    var listArticles : [Article] = []
    var selectedArticle : Int = 0
    var currentIndex : Int = 0
    
    static let storyboardIdentifier = "PagerArticles"
    //----------------------------------------------------------------------------
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    //----------------------------------------------------------------------------
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        self.setupNavBar()
        let startingViewController: ArticleDetailViewController = viewControllerAtIndex(index: selectedArticle)!
        
        //make view controllers
        let viewControllers = [startingViewController]
        self.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)

    }
    //----------------------------------------------------------------------------
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //----------------------------------------------------------------------------
    //MARK: Navigation methods
    //----------------------------------------------------------------------------
    
    func setupNavBar() {
        let backButton = UIBarButtonItem(customView: self.backBarButtonView)
        self.navigationItem.leftBarButtonItem = backButton
        
        if(Device.IS_IPHONE_5 || Device.IS_IPHONE_4_OR_LESS) {
            var titleFrame = self.titleImageView.frame
            titleFrame.origin.x = titleFrame.origin.x - 22
            self.titleImageView.frame = titleFrame
        }
    }
    //----------------------------------------------------------------------------
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //----------------------------------------------------------------------------
    //MARK: UIPagerViewController Datasource
    //----------------------------------------------------------------------------
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! ArticleDetailViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        
        return viewControllerAtIndex(index: index)
    }
    //----------------------------------------------------------------------------
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! ArticleDetailViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        
        if (index == self.listArticles.count) {
            return nil
        }
        
        return viewControllerAtIndex(index: index)
    }
    //----------------------------------------------------------------------------
    func viewControllerAtIndex(index: Int) -> ArticleDetailViewController?
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController : ArticleDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ArticleDetailViewController.storyboardIdentifier) as! ArticleDetailViewController
        pageContentViewController.article = self.listArticles[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        return pageContentViewController
    }
    //----------------------------------------------------------------------------
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return self.listArticles.count
    }
    //----------------------------------------------------------------------------
    //MARK: Share Action
    //----------------------------------------------------------------------------
    @IBAction func shareAction(_ sender: Any) {
        let article : Article = self.listArticles[selectedArticle]
        
        let textToShare = article.t
        
        if let urlRelative = NSURL(string: article.ua) {
            if let url = URL(string:"\(urlJDD.baseUrl)\(urlRelative)") {
                let objectsToShare = [textToShare, url] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                activityVC.popoverPresentationController?.sourceView = sender as? UIView
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
}

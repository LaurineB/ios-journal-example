//
//  ListArticlesViewController.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ListArticlesCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleImageView: UIImageView!
    
    static let storyboardIdentifier = "ListArticlesCollectionVC"
    var listArticles : [Article]? = nil
    var emptyView : EmptyDataView? = nil
    private let refreshControl = UIRefreshControl()
    
    //----------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupRefreshControl()
        
        let nib = UINib(nibName: "FirstArticleCell", bundle: nil)
        self.collectionView?.register(nib, forCellWithReuseIdentifier: FirstArticleCell.identifier)
        
        //Ne fonctionne pas comme ça, peut etre une vue controller à present?
        self.emptyView = EmptyDataView()
        emptyView?.isHidden = true
        self.view.addSubview(emptyView!)
        
    
        ArticleRequest.shared.getArticles(success: { (result) in
            self.listArticles = result
            self.collectionView?.reloadData()
        }) {
            print("Aucun articles valables ")
        }
    }
    //----------------------------------------------------------------------------
    override func viewDidAppear(_ animated: Bool) {
        
        ArticleRequest.shared.getArticles(success: { (result) in
            self.listArticles = result
        }) {
            self.listArticles = ArticleRequest.shared.getArticlesSaved()
        }
    }
    
    //----------------------------------------------------------------------------
    //MARK: Setup methods
    //----------------------------------------------------------------------------
    func setupRefreshControl() {
        
        if #available(iOS 10.0, *) {
            collectionView?.refreshControl = refreshControl
        } else {
            collectionView?.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(pulltoRefreshAction(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.red
    }
    
    //----------------------------------------------------------------------------
    func setupNavigationBar() {
        //Setting button
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"settings"), for: .normal)
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        menuBtn.addTarget(self, action: #selector(onSettingsButtonPress(_:)), for: UIControlEvents.touchUpInside)
        
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        navigationItem.rightBarButtonItem = menuBarItem
        
        //Title view adapt for iphone 4 & 5
        if(Device.IS_IPHONE_5 || Device.IS_IPHONE_4_OR_LESS) {
            var titleFrame = self.titleImageView.frame
            titleFrame.origin.x = titleFrame.origin.x + 30
            self.titleImageView.frame = titleFrame
        }
    }
    
    //----------------------------------------------------------------------------
    func refreshData() {
        ArticleRequest.shared.getArticles(success: { (result) in
            self.listArticles = result
            self.refreshControl.endRefreshing()
            self.collectionView?.reloadData()
        }) {
            print("Aucun articles valables ")
        }
    }
    //----------------------------------------------------------------------------
    @objc private func pulltoRefreshAction(_ sender: Any) {
        // Fetch Weather Data
        refreshData()
    }
    //----------------------------------------------------------------------------
    //MARK: UICollectionView DataSource
    //----------------------------------------------------------------------------
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let article = self.listArticles?[indexPath.row]
        
        if(indexPath.row == 0) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstArticleCell.identifier, for: indexPath) as! FirstArticleCell
            
            if let urlImg = article?.i.uc{
                cell.setup(titre: article?.t, hour: article?.d.hourStringFromInterval(), imageURL:urlImg)
            }
            
            return cell;
        } else {
     
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListArticlesCollectionViewCell.identifier, for: indexPath) as! ListArticlesCollectionViewCell
            
            if let urlImg = article?.i.uc{
                cell.setup(titre: article?.t, hour: article?.d.hourStringFromInterval(), imageURL:urlImg)
            }
            
            return cell;
        }
        
       
        
    }
    //----------------------------------------------------------------------------
    //MARK: UICollectionView Delegate
    //----------------------------------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(indexPath.row == 0) {
            return CGSize(width: (self.collectionView?.frame.size.width)!, height: (self.collectionView?.frame.size.height)!*0.85)
        } else {
            return CGSize(width: (self.collectionView?.frame.size.width)!, height: 300)
        }
       
    }
    //----------------------------------------------------------------------------
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    //----------------------------------------------------------------------------
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = self.listArticles?.count {
            return count
        } else {
            return 0
        }
    }
    //----------------------------------------------------------------------------
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedArticleIndex = indexPath.row
        
        let pager : PagerArticles = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PagerArticles.storyboardIdentifier) as! PagerArticles
        pager.listArticles = self.listArticles!
        pager.selectedArticle = selectedArticleIndex
        
        self.navigationController?.pushViewController(pager, animated: true)
    }
//----------------------------------------------------------------------------
    //MARK: Action Button
    //----------------------------------------------------------------------------
    @objc func onSettingsButtonPress(_ sender: UIButton) {
        let vc : SettingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: SettingsViewController.storyboardIdentifier) as! SettingsViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //----------------------------------------------------------------------------
    //MARK: EmptyView action
    //----------------------------------------------------------------------------
    func showEmptyView(){
        self.emptyView?.isHidden = false
    }
    
    func hideEmptyView(){
        self.emptyView?.isHidden = true
    }
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

extension String {
    func hourStringFromInterval() -> String{
        let date = Date(timeIntervalSinceReferenceDate: TimeInterval(Int(self)!))
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr_FR")
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .none
        
        return dateFormatter.string(from: date as Date)
    }
}

//
//  SettingsViewController.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class SettingsViewController : UIViewController {
    static let storyboardIdentifier = "SettingsVC"
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

extension SettingsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            SVProgressHUD.show(withStatus: "Vidage du cache")
            Configuration.shared.cleanCache(success: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                SVProgressHUD.dismiss()
            }) {
                SVProgressHUD.dismiss()
            }
            
        } else {
            
        }
    }
    
}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

extension SettingsViewController  : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return 2
        } else {
            return 2
        }
    }
    
    //----------------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //----------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0) {
            if(indexPath.row == 0) {
                return 61.0
            } else if(indexPath.row == 1){
                return 144.0
            }
        }
        
        return 61.0
    }
    
    //----------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0) {
            
            if(indexPath.row == 0) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: VideCacheCell.identifier, for: indexPath) as! VideCacheCell
                cell.setupCell()
                return cell
                
            } else if(indexPath.row == 1) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: PoliceCell.identifier, for: indexPath) as! PoliceCell
                return cell
                
            } else {
                return UITableViewCell()
            }
        } else {
             return UITableViewCell()
        }
       
    }
}

//
//  Configuration.swift
//  jdd-v2
//
//  Created by laurine baillet on 26/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import Kingfisher
import Disk
import SVProgressHUD

class Configuration {
    
    static let shared = Configuration()
    
    func launchConfigurationApp() {
        self.configureCacheManager()
    }
    
    //MARK: Cache manager
    private func configureCacheManager(){
        //Set cache max to 10 MB for images
        KingfisherManager.shared.cache.maxDiskCacheSize = 10000000
        
    }
    /**
     Clean cache used by Kingfisher & Disk
    */
    func cleanCache(success: @escaping () -> Void, error: () -> Void) {
        // Clean Disk
        DiskHelper.shared.cleanCache {
            SVProgressHUD.showError(withStatus: "Vidage des articles impossible")
        }
        
        SVProgressHUD.show(withStatus: "Vidage du cache")
        
        // Clean Kingficher
        KingfisherManager.shared.cache.cleanExpiredDiskCache {
            KingfisherManager.shared.cache.clearMemoryCache()
            KingfisherManager.shared.cache.clearDiskCache(completion: {
                success()
            })
        }
    }
    

}

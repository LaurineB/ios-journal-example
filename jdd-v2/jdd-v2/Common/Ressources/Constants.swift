//
//  Constants.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit

struct urlJDD {
    
    static let baseUrl = ""
    static let testBaseUrl = ""
    
    static let allArticles = ""
    static let getArticle = ""
    
    static let testAllArticles = ""
    static let testArticle = ""
    
    static let locationMap = ""
    
    static let testLocationMap = ""
    
    static let resizeImage = ""
}

struct RouteJDD {
    static let APP_SCHEME = ""
    
}

struct Filename {
    static let allArticles = "articles"
    static let journal = "journal"
}

struct Device {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(SCREEN_WIDTH, SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(SCREEN_WIDTH, SCREEN_HEIGHT)
    
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_6_OR_GREATER =  UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH  >= 667.0
    static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812.0
}

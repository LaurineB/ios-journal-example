//
//  Utils.swift
//  jdd-v2
//
//  Created by laurine baillet on 28/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation

class Utils {
    static let shared = Utils()
    
    /**
     Give the path url of a resized image
     
     - Parameter path: url of the image
     - Parameter width: width of the image returned
     - Parameter height: height of the image returned
     - Returns: the string path of the image resized
    */
    static func urlResizeImage(path: String,width: Int, height: Int ) -> String {
        let resizeUrl = urlJDD.resizeImage
        
        if resizeUrl.isEmpty {
            return path
        }
        let url = URL(string: path)
        if var pathComponents : [String] = url?.pathComponents {
            pathComponents.removeFirst()
             pathComponents[1] = "\(width),\(height)"
            let newPath = pathComponents.joined(separator: "/")
            
            return "\(resizeUrl)\(newPath)"
        }
       
       return path
    }
    
    /**
     Give the path of the resized image for the first cell
     
     - Parameter path: path of the image
     - Returns: path of the image resized
    */
    static func urlResizeForFirstCell(path: String) -> String {
        return self.urlResizeImage(path: path,width:375, height:390)
    }
    /**
     Give the path of the resized image for the cells of the article collection view
     
     - Parameter path: path of the image
     - Returns: path of the image resized
     */
    static func urlResizeForListArticleCell(path: String) -> String{
        return self.urlResizeImage(path: path,width:375, height:230)
    }
    /**
     Give the path of the resized image for detail article
     
     - Parameter path: path of the image
     - Returns: path of the image resized
     */
    static func urlResizeForArticle(path: String) -> String {
        return self.urlResizeImage(path: path,width:375, height:300)
    }
}

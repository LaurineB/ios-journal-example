//
//  DiskHelper.swift
//  jdd-v2
//
//  Created by laurine baillet on 27/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import Disk

class DiskHelper {
    
    static let shared = DiskHelper()
    
    /**
     Clean cache of Disk
    */
    func cleanCache(failed: () -> Void) {
        do {
            try Disk.clear(.applicationSupport)
        } catch{
            print("Error when clean cache of Disk with directory Application Support")
            failed()
        }
    }
    
    /**
     Get size cache of the Application Support directory manage by Disk
     */
    func getCacheSize() -> String {
        do {
            let bundle = Bundle.main.bundleURL
            var urlDiskDirectory : String = Disk.Directory.applicationSupport.pathDescription
            urlDiskDirectory.removeFirst(19)
            return try self.findSize(path: "\(bundle)\(urlDiskDirectory)/")
        
        } catch {
            print("Error when caculate cache from Disk")
        }
        return ""
    }
    /**
     Find size of a directory at path.
     
     - Parameter path: String path of the directory
     - Returns: size in bytes
    */
    func findSize(path: String) throws -> String {
        
        let fullPath = (path as NSString).expandingTildeInPath
        let fileAttributes: NSDictionary = try FileManager.default.attributesOfItem(atPath: fullPath) as NSDictionary
        
        if fileAttributes.fileType() == "NSFileTypeRegular" {
            return sizeToPrettyString(size: fileAttributes.fileSize())
        }
        
        let url = NSURL(fileURLWithPath: fullPath)
        if let directoryEnumerator = FileManager.default.enumerator(at: url as URL, includingPropertiesForKeys: [URLResourceKey.fileSizeKey], options: [.skipsHiddenFiles], errorHandler: nil) {
            var total: UInt64 = 0
            
            for (index, object) in directoryEnumerator.enumerated() {
                if let fileURL = object as? NSURL {
                    var fileSizeResource: AnyObject?
                    try fileURL.getResourceValue(&fileSizeResource, forKey: URLResourceKey.fileSizeKey)
                    guard let fileSize = fileSizeResource as? NSNumber else { continue }
                    total += fileSize.uint64Value
                    if index % 1000 == 0 {
                        print(".", terminator: "")
                    }
                }
                
            }
            
            if total < 1048576 {
                total = 1
            }
            else
            {
                total = UInt64(total / 1048576)
            }
            
            return sizeToPrettyString(size: total)
        }
        return ""
    }
    
    /**
     Convert UInt64 in String
     
     - Parameter size: size to convert
     - Returns: string conversion of the given UInt64
    */
    private func sizeToPrettyString(size: UInt64) -> String {
        
        let byteCountFormatter = ByteCountFormatter()
        byteCountFormatter.allowedUnits = .useMB
        byteCountFormatter.countStyle = .file
        let folderSizeToDisplay = byteCountFormatter.string(fromByteCount: Int64(size))
        
        return folderSizeToDisplay
        
    }
}

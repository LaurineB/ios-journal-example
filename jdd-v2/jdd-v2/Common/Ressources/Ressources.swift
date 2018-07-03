//
//  Ressources.swift
//  jdd-v2
//
//  Created by laurine baillet on 25/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import UIKit

enum FontJDD {
    case mayeurTitreNoir
    case mayeurTitreNormal
    case mayeurButtonNoir
    case AGaramondProSemiBold
    case GaramondPremrPro
    
    func getFont() -> UIFont {
        switch self {
        case .mayeurTitreNoir:
            return  UIFont(name: "MayeurTitre-Noir", size: 21)!
        case .mayeurTitreNormal:
            return  UIFont(name: "MayeurTitre-Normal", size: 18)!
        case .mayeurButtonNoir:
            return  UIFont(name: "MayeurTitre-Noir", size: 17)!
        case .AGaramondProSemiBold:
            return  UIFont(name: "AGaramondPro-Semibold", size: 13)!
        case .GaramondPremrPro:
            return  UIFont(name: "GaramondPremrPro", size: 13)!
        default:
            return  UIFont(name: "MayeurTitre-Noir", size: 21)!
        }
    }
}

enum ColorJDD {
    case red
    
    func getColor() -> UIColor {
        switch self {
        case .red:
            return UIColor(red: 236, green: 236, blue: 236, alpha: 1)
        default:
            return UIColor(red: 236, green: 236, blue: 236, alpha: 1)
        }
    }
}

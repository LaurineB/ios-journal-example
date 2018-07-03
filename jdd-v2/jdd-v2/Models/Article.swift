//
//  Article.swift
//  jdd-v2
//
//  Created by laurine baillet on 19/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation

typealias Flux = [FluxElement]

struct FluxElement: Codable {
    let it: Article?
    let journal: Journal?
}
/**
 Object Article
 
 t = title
 r = rubrique
 d = date
 itIn = chapeau
 dsc = contenu
 ua = url de l'article sur le web
 a = auteur
 i = objet I = Image
 
 */
struct Article: Codable {
    let t: String
    let r: String
    let d, itIn, dsc, ua: String
    let a: String
    let i: I
    
    enum CodingKeys: String, CodingKey {
        case t, r, d
        case itIn = "in"
        case dsc, ua, a, i
    }
}

/**
 Objet I (Image)
 u = url de l'image
 uc = url de l'image croppé à 600,600
 */
struct I: Codable {
    let u, uc, c: String
}

/**
 Objet Journal
 
 ne contient qu'une url
 */
struct Journal: Codable {
    let url: String
}

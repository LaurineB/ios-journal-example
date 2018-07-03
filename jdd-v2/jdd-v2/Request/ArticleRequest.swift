//
//  ArticleRequest.swift
//  jdd-v2
//
//  Created by laurine baillet on 21/06/2018.
//  Copyright © 2018 laurine baillet. All rights reserved.
//

import Foundation
import Disk
import Alamofire

class ArticleRequest {
    
    static let shared = ArticleRequest()
    var flux : Flux? = nil
    
    //----------------------------------------------------------------------------
    /**
     Get Articles from API, if no connection, get Articles from cache
    */
    func getArticles(success: @escaping ([Article]) -> Void, failed: @escaping () -> Void)  {
         Alamofire.request(URL(string: urlJDD.allArticles)!).responseJSON { response in
            DispatchQueue.main.async {
                switch response.result {
                case .success:
                    let jsonData = response.data
                    do{
                        self.flux = try JSONDecoder().decode(Flux.self, from: jsonData!)
                        self.saveJournal()
                        self.saveArticles()
                        print("Article Request : refresh data")
                        if let articles = self.getArticlesSaved() {
                             success(articles)
                        } else {
                            failed()
                        }
                       
                    }catch {
                        print("Error: \(error)")
                        failed()
                    }
                case .failure(let error):
                    print(error)
                    failed()
                }
            }
        }
    }
    
    //----------------------------------------------------------------------------
    /**
     Save Journal to Cache with Disk
    */
    fileprivate func saveJournal() {
         let journal : Journal? = self.flux?.last?.journal
        do {
            try Disk.save(journal, to: .applicationSupport, as: Filename.journal)
        } catch {
            
        }
    }
    
    //----------------------------------------------------------------------------
    /**
     Get Journal from cache with Disk
    */
    func getJournal() -> Journal? {
        do {
            let retrieved : Journal? = try Disk.retrieve(Filename.journal, from: .applicationSupport, as: Journal.self)
            return retrieved
        } catch {
            
        }
        return nil
    }
    
    //----------------------------------------------------------------------------
    /**
     Save all articles to cache with Disk
    */
    fileprivate func saveArticles() {

        if(self.flux != nil) {
            var arrayArticles : [Article] = []
            
            for fluxElement : FluxElement in self.flux! {
                if let article = fluxElement.it {
                     arrayArticles.append(article)
                }
            }
            
            do {
               try Disk.save(arrayArticles, to: .applicationSupport, as: Filename.allArticles)
            } catch {
                
            }
        }
        
    }
    
    //----------------------------------------------------------------------------
    /**
     Get all articles from cache with Disk
    */
    func getArticlesSaved() -> [Article]? {
        do {
            let retrieved : [Article]? = try Disk.retrieve(Filename.allArticles, from: .applicationSupport, as: [Article].self)
            return retrieved
        } catch {
            
        }
        return nil
    }
}

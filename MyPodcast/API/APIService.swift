//
//  APIService.swift
//  MyPodcast
//
//  Created by SEAN on 2018/4/2.
//  Copyright © 2018年 SEAN. All rights reserved.
//

import UIKit
import Alamofire
import FeedKit

class APIService{
    
    let baseUrl = "https://itunes.apple.com/search"
    //singleton
    static let shared = APIService()
    
    func fetchEpisode(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()){
     
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl : feedUrl.replacingOccurrences(of: "http", with: "https")
        
        
        guard let url = URL(string: secureFeedUrl) else { return }
        
        DispatchQueue.global(qos: .background).async {
         
            let parser = FeedParser(URL: url)
            parser?.parseAsync(result: { (result) in
                
                if let err = result.error {
                    print("failed to parse XML feed:", err)
                    return
                }
                
                guard let feed = result.rssFeed else { return }
                let episodes = feed.toEpisodes()
                completionHandler(episodes)
                
            })
        }
    }
    
    func fetchPodcast(searchText: String, completionHandler: @escaping ([Podcast]) -> ()){
        
        let parameters = ["term": searchText, "media": "podcast"]
        Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let err = dataResponse.error {
                print("failed to contact itunes:", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            
            do{
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            }catch let decodeErr {
                print("failed to decode:", decodeErr)
            }
        }
        
    }
    
    struct SearchResults: Decodable {
        let resultCount: Int
        let results: [Podcast]
    }
    
}

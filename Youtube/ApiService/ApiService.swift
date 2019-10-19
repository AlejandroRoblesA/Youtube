//
//  ApiService.swift
//  Youtube
//
//  Created by Alejandro on 14/10/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video])-> ()){
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video])-> ()){
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video])-> ()){
        
        fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video])->()){
        
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil{
                print (error!)
                return
            }

            do{
                
                if let unwrappedData = data,
                   let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]]{
                    
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({ return Video(dictionary: $0)}))
                    }
                }
            }catch let jsonError{
                print (jsonError)
            }
        }).resume()
    }
    
}

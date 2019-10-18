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
    
    func fetchVideos(completion: @escaping ([Video])-> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error != nil{
                        print (error!)
                        return
                    }

                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        
                        var videos = [Video]()
                        
                        for dictionary in json as! [[String: AnyObject]]{
                            
                            let video = Video()
                            video.title = dictionary["title"] as? String
                            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                            
                            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                            
                            let channel = Channel()
                            channel.profileImageName = channelDictionary["profile_image_name"] as? String
                            channel.name = channelDictionary["name"] as? String
                            
                            video.channel = channel
                            
                            videos.append(video)
                            
                        }
                        
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                        
                    }catch let jsonError{
                        print (jsonError)
                    }
                }).resume()
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video])-> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json")!
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if error != nil{
                        print (error!)
                        return
                    }

                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        
                        var videos = [Video]()
                        
                        for dictionary in json as! [[String: AnyObject]]{
                            
                            let video = Video()
                            video.title = dictionary["title"] as? String
                            video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                            
                            let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                            
                            let channel = Channel()
                            channel.profileImageName = channelDictionary["profile_image_name"] as? String
                            channel.name = channelDictionary["name"] as? String
                            
                            video.channel = channel
                            
                            videos.append(video)
                            
                        }
                        
                        DispatchQueue.main.async {
                            completion(videos)
                        }
                        
                    }catch let jsonError{
                        print (jsonError)
                    }
                }).resume()
    }
    
}

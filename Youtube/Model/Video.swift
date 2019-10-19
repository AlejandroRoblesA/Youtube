//
//  Video.swift
//  Youtube
//
//  Created by Alejandro on 8/6/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    //This names has to be the same named as the JSON content to use the method, setValuesForKeys
    //And also for it's works correctly has to set @objc at the beginning
    @objc var thumbnail_image_name: String?
    @objc var title: String?
    @objc var number_of_views: NSNumber?
    @objc var uploadDate: NSDate?
    @objc var duration: NSNumber?
    
    @objc var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        
        if (key == "channel"){
            let channelDictionary = value as! [String: AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(channelDictionary)
        }
        else{
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: NSObject {
    @objc var name: String?
    @objc var profile_image_name: String?
}

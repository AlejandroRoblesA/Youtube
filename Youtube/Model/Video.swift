//
//  Video.swift
//  Youtube
//
//  Created by Alejandro on 8/6/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName : String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}

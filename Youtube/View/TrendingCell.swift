//
//  TrendingCell.swift
//  Youtube
//
//  Created by Alejandro on 18/10/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}

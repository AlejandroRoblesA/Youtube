//
//  FeedCell.swift
//  Youtube
//
//  Created by Alejandro on 16/10/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class FeedCell: BaseCell {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .blue
        addSubview(collectionView)
        
        addConstraintsWithFornat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFornat(format: "V:|[v0]|", views: collectionView)
    }
    
}

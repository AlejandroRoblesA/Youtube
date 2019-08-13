//
//  ViewController.swift
//  Youtube
//
//  Created by Alejandro on 7/28/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [Video] = {
//
//        var nitaChannel = Channel()
//        nitaChannel.name = "NitaIsTheBestChannel"
//        nitaChannel.profileImageName = "nita"
//
//        var simone = Video()
//        simone.title = "Epica - Simone Simons"
//        simone.thumbnailImageName = "simoneSimons"
//        simone.channel = nitaChannel
//        simone.numberOfViews = 3123456789
//
//        var alissa =  Video()
//        alissa.title = "ARCH ENEMY - You Will Know My Name (OFFICIAL VIDEO)"
//        alissa.thumbnailImageName = "alissa"
//        alissa.channel = nitaChannel
//        alissa.numberOfViews = 3987123464
//
//
//        return [alissa, simone]
//    }()

    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(20))
        navigationItem.titleView = titleLabel
        
        collectionView.backgroundColor = .white
        
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func fetchVideos(){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil{
                print (error!)
                return
            }

            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                self.videos = [Video]()
                
                for dictionary in json as! [[String: AnyObject]]{
                    
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    self.videos?.append(video)
                    
                }
                
                self.collectionView.reloadData()
                
            }catch let jsonError{
                print (jsonError)
            }
            
//            let str = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(str!)
        }).resume()
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage (named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    @objc func handleSearch(){
        
    }
    
    @objc func handleMore(){
        
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFornat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFornat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

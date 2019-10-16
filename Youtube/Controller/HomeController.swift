//
//  ViewController.swift
//  Youtube
//
//  Created by Alejandro on 7/28/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]?
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(20))
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = .white
        
//        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        collectionView.isPagingEnabled = true
    }
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchVideos { (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage (named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    }
    
    @objc func handleSearch(){
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc func handleMore(){
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting){
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        dummySettingsViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar(){
        
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 32)
        view.addSubview(redView)
        view.addConstraintsWithFornat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFornat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFornat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFornat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//        return videos?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
//        cell.video = videos?[indexPath.item]
//
//        return cell
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height = (view.frame.width - 16 - 16) * 9 / 16
//        return CGSize(width: view.frame.width, height: height + 16 + 88)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Alejandro on 20/10/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        let urlString = "https://firebasestorage.googleapis.com/v0/b/chat-11c7d.appspot.com/o/someFileName.mov?alt=media&token=0f3d5579-7dd8-47d9-ac68-0d1724d82c6d"
        
        if let url = URL(string: urlString){
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class VideoLauncher: NSObject{
    
    func showVideoPlayer(){
        print("Animation")
        
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            //16 * 9 is the aspect ratio of all HD videos
            let height = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
    
}

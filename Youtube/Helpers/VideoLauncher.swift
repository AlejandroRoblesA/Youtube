//
//  VideoLauncher.swift
//  Youtube
//
//  Created by Alejandro on 20/10/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

class VideoLauncher: NSObject{
    
    func showVideoPlayer(){
        print("Animation")
        
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }) { (completedAnimation) in
                //some code
            }
        }
    }
    
}

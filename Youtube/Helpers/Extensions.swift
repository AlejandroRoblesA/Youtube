//
//  Extensions.swift
//  Youtube
//
//  Created by Alejandro on 8/1/19.
//  Copyright © 2019 Alejandro. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView{
    func addConstraintsWithFornat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

var imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error != nil{
                print (error!)
                return
            }
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                if (self.imageUrlString == urlString){
                    self.image = imageToCache
                    
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
                
            }
            
        }).resume()
    }
}

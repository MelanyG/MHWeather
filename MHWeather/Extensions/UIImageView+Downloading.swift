//
//  UIImage+Downloading.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/20/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImageWithURL(url:String) {

        let sessionTask = URLSession.shared
        let request = URLRequest(url: URL(string:url)!)
        sessionTask.dataTask(with: request, completionHandler: { [unowned self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                let image: UIImage = UIImage(data: data!)!
                DispatchQueue.main.async {
                self.image = image
                }

            }

        }).resume()

    }
}





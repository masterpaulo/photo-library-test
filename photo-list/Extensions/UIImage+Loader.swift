//
//  UIImage+Loader.swift
//  photo-list
//
//  Created by Master Paulo on 6/6/22.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImage {
    static func loadImageUsingCacheWithUrlString(_ urlString: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            completion(cachedImage)
        }

        //No cache, so create new one and set image
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }

            DispatchQueue.main.async(execute: {
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    completion(downloadedImage)
                }
            })

        }).resume()
    }
}

//
//  extensionUIImage.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func downloaded(from url: URL, completion: ((UIImage,String) -> Void)?) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.global().async() {
                completion?(image,url.absoluteString)
            }
            }.resume()
    }
    
    func downloaded(from link: String, completion: ((UIImage,String) -> Void)?) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, completion: completion)
    }
}

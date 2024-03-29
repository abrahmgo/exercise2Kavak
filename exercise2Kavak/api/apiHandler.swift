//
//  apiHandler.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import UIKit

class apiHandler {
    
    let session = URLSession.shared
    
    func downloadData(url: String, completion: @escaping ((Int,[String:Any]) -> Void))
    {
        guard let requestUrl = URL(string:url) else { return }
        let request = URLRequest(url:requestUrl)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if error == nil{
                    do{
                        let str = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
                        completion(httpResponse.statusCode,str)
                    }
                    catch {
                        completion(httpResponse.statusCode,["message":"formato de respuesta incorrecto"])
                    }
                } else {
                    completion(httpResponse.statusCode,["message":"información no disponible"])
                }
            }else {
                completion(500,["message":"url no disponible"])
            }
        }
        task.resume()
    }
    
    func cleanGnomes(data : [[String:Any]],completion: @escaping (([gnome]) -> Void))
    {
        var gnomes = [gnome]()
        for oneGnome in data
        {
            let jsonData = oneGnome.json.data(using: .utf8)!
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let uniqueGnome = try! decoder.decode(gnome.self, from: jsonData)
            gnomes.append(uniqueGnome)
        }
        completion(gnomes)
    }
    
    func downLoadImages(imageUrls: [String], completion: @escaping (([String:UIImage]) -> Void))
    {
        let urlImages = imageUrls
        var arrImages = [String : UIImage]()
        let dispatchGroup = DispatchGroup()
        
        for urlImage in urlImages
        {
            dispatchGroup.enter()
            let imageDownloaded = UIImage()
            imageDownloaded.downloaded(from: urlImage) { (image, urlImage2) in
                DispatchQueue.main.async {
                    arrImages[urlImage2] = image
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            completion(arrImages)
        }
    }
}

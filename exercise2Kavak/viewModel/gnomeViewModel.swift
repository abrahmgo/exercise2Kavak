//
//  gnomeViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import UIKit

class gnomeViewModel {
    
    var apiManager = apiHandler()
    var dataSourceGnome = [gnome]()
    var dataSourceGnomeImages : [String:UIImage]?
    
    func getDataFromApi(withUrl: String, completion: @escaping (([String:Any]) -> Void))
    {
        apiManager.downloadData(url: withUrl) { (status, info) in
            completion(info)
        }
    }
    
    func downloadGnomes(withUrl: String, completion: @escaping ((Bool) -> Void))
    {
        getDataFromApi(withUrl: withUrl) { (data) in
            if let info = data["Brastlewark"] as? [[String:Any]]
            {
                self.apiManager.cleanGnomes(data: info) { (info) in
                    self.dataSourceGnome = info
                    self.getUniqueImages()
                    completion(true)
                }
            }
            else
            {
                self.dataSourceGnome.removeAll()
            }
        }
    }
    
    func donwloadImages(completion: @escaping (([String:UIImage]) -> Void))
    {
        let urlImages = getUniqueImages()
        apiManager.downLoadImages(imageUrls: urlImages) { (dicImages) in
            self.dataSourceGnomeImages = dicImages
            completion(dicImages)
        }
    }
    
    
    func getNumCellInSection() -> Int
    {
        return dataSourceGnome.count
    }
    
    func getGnomeAtIndex(index: Int) -> gnome
    {
        let gnomeIndex =  dataSourceGnome[index]
        return gnomeIndex
    }
    
    func getGnomeImageAtIndex(url: String) -> UIImage?
    {
        if dataSourceGnomeImages?.count != 0
        {
            guard let image = dataSourceGnomeImages?[url] else {
                return nil
            }
            return image
        }
        else
        {
            return nil
        }
    }
    
    func getUniqueHairColor() -> [String]
    {
        let hairColor = dataSourceGnome.map( {$0.hairColor! })
        return hairColor
    }
    
    func getUniqueProfessions() -> [String]
    {
        let profesion = dataSourceGnome.map( {$0.professions! })
        let reduceProfesion = profesion.reduce([], +)
        return reduceProfesion
    }
    
    func getMaxHeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.weight! }
        return weight.max()!
    }
    
    func getMinHeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.weight! }
        return weight.min()!
    }
    
    func getMaxAge() -> Int
    {
        let age = self.dataSourceGnome.map { $0.age! }
        return age.max()!
    }
    
    func getMinAge() -> Int
    {
        let age = self.dataSourceGnome.map { $0.age! }
        return age.min()!
    }
    
    func getUniqueImages() -> [String]
    {
        let images = self.dataSourceGnome.map( {$0.thumbnail!} )
        let reduceImages = Array(Set(images))
        return reduceImages
    }
}

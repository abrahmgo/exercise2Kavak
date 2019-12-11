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
    
    private let context = coreDataManager.shared.persistentContainer.viewContext
    private var localArrGnomes = [GnomeEntity]()
    
    var apiManager = apiHandler()
    var dataSourceGnome = [gnome]()
    var dataSourceGnomeFilter = [gnome]()
    var dataSourceGnomeSeachBar = [gnome]()
    var dataSourceGnomeImages : [String:UIImage]?
    
    func getDataFromApi(withUrl: String, completion: @escaping (([String:Any]) -> Void))
    {
        apiManager.downloadData(url: withUrl) { (status, info) in
            completion(info)
        }
    }
    
    func downloadGnomes(useFlag: Int, withUrl: String, completion: @escaping ((Bool) -> Void))
    {
        if useFlag == 1
        {
            getDataFromApi(withUrl: withUrl) { (data) in
                if let info = data["Brastlewark"] as? [[String:Any]]
                {
                    self.apiManager.cleanGnomes(data: info) { (info) in
                        self.dataSourceGnome = info
                        completion(true)
                    }
                }
                else
                {
                    self.dataSourceGnome.removeAll()
                    completion(false)
                }
            }
        }
        else
        {
            checkLocalData { (status) in
                completion(status)
            }
        }
    }
    
    func checkLocalData(completion: @escaping ((Bool) -> Void))
    {
        dataSourceGnome.removeAll()
        do{
            localArrGnomes = try context.fetch(GnomeEntity.fetchRequest())
            if localArrGnomes.count != 0
            {
                for data in localArrGnomes
                {
                    if let arrayFriends = data.friends as! NSArray as? [String], let arrayProfessions = data.professions as! NSArray as? [String]
                    {
                        let gnomeLocal = gnome(id: Int(data.id), name: data.name!, thumbnail: data.thumbnail!, age: Int(data.age), weight: data.weight, height: data.height, professions: arrayProfessions, friends: arrayFriends, hairColor: data.hairColor!)
                        self.dataSourceGnome.append(gnomeLocal)
                    }
                }
                print(dataSourceGnome.count)
                completion(true)
            }
            else
            {
                completion(false)
            }
        }catch _ as NSError{
            completion(false)
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
    
    
    func getNumCellInSection(enableFilter: Bool, filter: Bool) -> Int
    {
        if enableFilter
        {
            if filter
            {
                return dataSourceGnomeSeachBar.count
            }
            else
            {
                return dataSourceGnomeFilter.count
            }
        }
        else
        {
            if filter
            {
                return dataSourceGnomeSeachBar.count
            }
            else
            {
                return dataSourceGnome.count
            }
        }
    }
    
    func getGnomeAtIndex(enableFilter: Bool, filter: Bool, index: Int) -> gnome
    {
        if enableFilter
        {
            if filter
            {
                let gnomeIndex =  dataSourceGnomeSeachBar[index]
                return gnomeIndex
            }
            else
            {
                let gnomeIndex =  dataSourceGnomeFilter[index]
                return gnomeIndex
            }
        }
        else
        {
            if filter
            {
                let gnomeIndex =  dataSourceGnomeSeachBar[index]
                return gnomeIndex
            }
            else
            {
                let gnomeIndex =  dataSourceGnome[index]
                return gnomeIndex
            }
        }
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
    
    func getMaxWeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.weight! }
        return weight.max()!
    }
    
    func getMinWeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.weight! }
        return weight.min()!
    }
    
    func getMaxHeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.height! }
        return weight.max()!
    }
    
    func getMinHeight() -> Double
    {
        let weight = self.dataSourceGnome.map { $0.height! }
        return weight.min()!
    }
    
    func getMaxAge() -> Double
    {
        let age = self.dataSourceGnome.map { $0.age! }
        return Double(age.max()!)
    }
    
    func getMinAge() -> Double
    {
        let age = self.dataSourceGnome.map { $0.age! }
        return Double(age.min()!)
    }
    
    func getUniqueImages() -> [String]
    {
        let images = self.dataSourceGnome.map( {$0.thumbnail!} )
        let reduceImages = Array(Set(images))
        return reduceImages
    }
    
    func getDataSearchBar(enableFilter: Bool,searchText: String, completion: @escaping ((Bool) -> Void))
    {
        if enableFilter
        {
            dataSourceGnomeSeachBar = dataSourceGnome.filter({ (flinkerFiltered) -> Bool in
                return (flinkerFiltered.name!.lowercased().contains(searchText.lowercased()))
            })
        }
        else
        {
            dataSourceGnomeSeachBar = dataSourceGnomeFilter.filter({ (flinkerFiltered) -> Bool in
                return (flinkerFiltered.name!.lowercased().contains(searchText.lowercased()))
            })
        }
        completion(true)
    }
    
    func getDataFilter(filters: [String:Any], completion: @escaping ((Bool) -> Void))
    {
        if filters.count != 0
        {
            var flag = false
            for (key,value) in filters{
                if key == "hairColor"
                {
                    let hair = value as! String
                    if flag
                    {
                        self.dataSourceGnomeFilter = dataSourceGnomeFilter.filter({ (gnome) -> Bool in
                            gnome.hairColor == hair
                        })
                    }
                    else
                    {
                        self.dataSourceGnomeFilter = dataSourceGnome.filter({ (gnome) -> Bool in
                            gnome.hairColor == hair
                        })
                    }
                    flag = true
                }
                else if key == "profession"
                {
                    let profession = value as! String
                    if flag
                    {
                        self.dataSourceGnomeFilter = dataSourceGnomeFilter.filter({ (gnome) -> Bool in
                            gnome.professions!.contains(profession)
                        })
                    }
                    else
                    {
                        self.dataSourceGnomeFilter = dataSourceGnome.filter({ (gnome) -> Bool in
                            gnome.professions!.contains(profession)
                        })
                    }
                    flag = true
                }
                else if key == "age"
                {
                    let age = value as! Int
                    if flag
                    {
                        self.dataSourceGnomeFilter = dataSourceGnomeFilter.filter({ (gnome) -> Bool in
                            gnome.age! <= age
                        })
                    }
                    else
                    {
                        self.dataSourceGnomeFilter = dataSourceGnome.filter({ (gnome) -> Bool in
                            gnome.age! <= age
                        })
                    }
                    flag = true
                }
                
                else if key == "weight"
                {
                    let weight = value as! Float
                    if flag
                    {
                        self.dataSourceGnomeFilter = dataSourceGnomeFilter.filter({ (gnome) -> Bool in
                            gnome.weight! <= Double(weight)
                        })
                    }
                    else
                    {
                        self.dataSourceGnomeFilter = dataSourceGnome.filter({ (gnome) -> Bool in
                            gnome.weight! <= Double(weight)
                        })
                    }
                    flag = true
                }
                else if key == "height"
                {
                    let height = value as! Float
                    if flag
                    {
                        self.dataSourceGnomeFilter = dataSourceGnomeFilter.filter({ (gnome) -> Bool in
                            gnome.height! <= Double(height)
                        })
                    }
                    else
                    {
                        self.dataSourceGnomeFilter = dataSourceGnome.filter({ (gnome) -> Bool in
                            gnome.height! <= Double(height)
                        })
                    }
                    flag = true
                }
            }
        }
        else
        {
            dataSourceGnomeFilter.removeAll()
        }
        if dataSourceGnomeFilter.count != 0
        {
            completion(true)
        }
        else
        {
            completion(false)
        }
    }
    

}

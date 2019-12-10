//
//  gnomeViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

class gnomeViewModel {
    
    var apiManager = apiHandler()
    var dataSourceGnome = [gnome]()
    
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
                    completion(true)
                }
            }
            else
            {
                self.dataSourceGnome.removeAll()
            }
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
}

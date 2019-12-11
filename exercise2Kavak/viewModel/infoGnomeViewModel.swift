//
//  infoGnomeViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

class infoGnomeViewModel{
    
    static let shared = infoGnomeViewModel()
    private let context = coreDataManager.shared.persistentContainer.viewContext
    weak var delegate: updateViewFavorites?
    
    func saveGnome(infoGnome: gnome) -> String
    {
        let gnomeSave = GnomeEntity(entity: GnomeEntity.entity(), insertInto: self.context)
        gnomeSave.age = Int16(infoGnome.age!)
        gnomeSave.name = infoGnome.name!
        gnomeSave.height = infoGnome.height!
        gnomeSave.id = Int16(infoGnome.id!)
        gnomeSave.hairColor = infoGnome.hairColor
        gnomeSave.thumbnail = infoGnome.thumbnail
        gnomeSave.weight = infoGnome.weight!
        gnomeSave.friends = infoGnome.friends! as NSObject
        gnomeSave.professions = infoGnome.friends! as NSObject
        if coreDataManager.shared.saveContext()
        {
            return "you are making new friendships 😍"
        }
        else
        {
            return "somethin is wrong 😩"
        }
    }
    
    func deleteGnome(useFlag: Int, entityName: String, infoGnome: gnome) -> String
    {
        if coreDataManager.shared.deleteRegister(entityName, id: String(infoGnome.id!))
        {
            if useFlag == 0
            {
                delegate?.updateView(true)
            }
            return "he doesn't want your friendship 🥶"
        }
        else
        {
            return "something is wrong 😩"
        }
    }
    
    func statusFavoriteGnome(useFlag: Int, status: Bool, entityName: String, infoGnome: gnome) -> String
    {
        if status
        {
            let message = saveGnome(infoGnome: infoGnome)
            return message
        }
        else
        {
            let message = deleteGnome(useFlag: useFlag, entityName: entityName, infoGnome: infoGnome)
            return message
        }
    }
    
    func isFavoriteGnome(entityName: String, infoGnome: gnome) -> Bool
    {
        if let result = coreDataManager.shared.searchRegister(entityName, id: String(infoGnome.id!))
        {
            if result.count != 0
            {
                return true
            }
            else
            {
                return false
            }
        }
        return false
    }
}

protocol updateViewFavorites: class {
    func updateView(_ flag: Bool)
}

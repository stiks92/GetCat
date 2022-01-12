//
//  CatStorage.swift
//  GetCat
//
//  Created by Вадим Брацюн on 23.09.2021.
//

import Foundation
import RealmSwift

class CatStorage {
    static let shared = CatStorage()
    
    private let realm = try! Realm()
    
    func addObject(object: CatModel) {
        
        let cat = CatStorageModel()
        
        cat.id = object.id ?? ""
        cat.url = object.url ?? ""
        cat.height = object.height ?? 0
        cat.width = object.width ?? 0
        
        try! realm.write {
            realm.add(cat)
        }
    }
    
    func getObject() -> [CatModel] {
        
        var array = [CatModel]()
        let allCats = realm.objects(CatStorageModel.self)
        for dataObject in allCats {
            var newObject = CatModel()
            newObject.id = dataObject.id
            newObject.url = dataObject.url
            newObject.height = dataObject.height
            newObject.width = dataObject.width
            array.append(newObject)
        }
        return array
    }
    
    func deleteObject(object: CatModel) {
        let memory = realm.objects(CatStorageModel.self)
        if let memoryURL = memory.first(where: { $0.url == object.url }) {
            try! realm.write {
                realm.delete(memoryURL)
            }
        }
    }
}


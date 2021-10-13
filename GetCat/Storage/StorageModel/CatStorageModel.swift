//
//  CatStorageModel.swift
//  GetCat
//
//  Created by Вадим Брацюн on 28.09.2021.
//

import Foundation
import RealmSwift

class CatStorageModel: Object {
    @objc dynamic var id = ""
    @objc dynamic var url = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
}

//
//  CatInfo.swift
//  GetCat
//
//  Created by Вадим Брацюн on 22.09.2021.
//

import Foundation

// MARK: - CatInfo
struct CatInfo: Codable {
    
    let id: String?
    let url: String?
    let width, height: Int?
}

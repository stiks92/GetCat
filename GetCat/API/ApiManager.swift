//
//  ApiManager.swift
//  GetCat
//
//  Created by Вадим Брацюн on 22.09.2021.
//

import Foundation
import Alamofire

class ApiManager {
    
    static let shared = ApiManager()
    
    let url = "https://api.thecatapi.com/v1/images/search?limit=20"
    
    func catParsing(completion: @escaping (CatModel) -> Void) {
        AF.request(self.url)
            .validate()
            .responseDecodable(of: [CatInfo].self, queue: .main) { response in
                
                if let data = response.value {
                        var newModel = CatModel()
                        for item in data {
                            newModel.id = item.id
                            newModel.url = item.url
                            newModel.height = item.height
                            newModel.width = item.height
                            completion(newModel)
                    }
                } else { return }
            }
    }
}

//
//  FavoriteCatCollectionViewCell.swift
//  GetCat
//
//  Created by Вадим Брацюн on 23.09.2021.
//

import UIKit
import Kingfisher

class FavoriteCatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var favoriteCatImage: UIImageView!
    
    func initCell(data: CatModel) {
        
        guard let url: URL = URL(string: data.url ?? "" ) else {fatalError("Failed to load url")}
        favoriteCatImage.kf.setImage(with: url)
    }
}

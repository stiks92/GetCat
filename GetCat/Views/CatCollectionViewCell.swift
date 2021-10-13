//
//  CatCollectionViewCell.swift
//  GetCat
//
//  Created by Вадим Брацюн on 22.09.2021.
//

import UIKit
import Kingfisher

class CatCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var catImage: UIImageView!
    
    func updateCell(data: CatModel?) {
        
        guard let url: URL = URL(string: data?.url ?? "") else {return}
        
        catImage.kf.setImage(with: url)
    }
}

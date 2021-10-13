//
//  SingleFavoriteCatViewController.swift
//  GetCat
//
//  Created by Вадим Брацюн on 24.09.2021.
//

import UIKit
import Kingfisher

class SingleFavoriteCatViewController: UIViewController {
    
    @IBOutlet weak var favoriteSingleCatImage: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    var favoriteCatModel = CatModel()
    
    var onDelete: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deleteButton.layer.cornerRadius = 8
        self.downloadButton.layer.cornerRadius = 8
        updateFavoriteImage()
    }
    
    @IBAction func deleteFromMemory(_ sender: Any) {
        CatStorage.shared.deleteObject(object: favoriteCatModel)
        onDelete?()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func downloadToMemory(_ sender: Any) {
        ImageSaver.shared.writeToPhotoAlbum(image: favoriteSingleCatImage.image!)
    }
    
    func updateFavoriteImage() {
        
        guard let url: URL = URL(string: favoriteCatModel.url ?? "") else {fatalError("Failed to load url")}
            
        favoriteSingleCatImage.kf.setImage(with: url)
    }

    
    @IBAction func closeController(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

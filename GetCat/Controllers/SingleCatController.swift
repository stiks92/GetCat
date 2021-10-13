//
//  SingleCatController.swift
//  GetCat
//
//  Created by Вадим Брацюн on 22.09.2021.
//

import UIKit
import Kingfisher

class SingleCatController: UIViewController {

    
    @IBOutlet weak var bigCatImage: UIImageView!
    
    @IBOutlet weak var favoritesButton: UIButton!
    
    @IBOutlet weak var downloadButton: UIButton!
    
    var catInfo: CatInfo? = nil
    
    var catModel = CatModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.favoritesButton.layer.cornerRadius = 8
        self.downloadButton.layer.cornerRadius = 8
        updateView()
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        
        CatStorage.shared.addObject(object: catModel)
    }
    
    @IBAction func downloadAtStorage(_ sender: Any) {
        
        ImageSaver.shared.writeToPhotoAlbum(image: bigCatImage.image!)
    }
    
    func updateView() {
        
        guard let url: URL = URL(string: catModel.url ?? "") else {return}
            
        bigCatImage.kf.setImage(with: url)
    }
    
    @IBAction func closeViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

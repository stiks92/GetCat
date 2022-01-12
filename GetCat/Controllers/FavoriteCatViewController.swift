//
//  FavoriteCatViewController.swift
//  GetCat
//
//  Created by Вадим Брацюн on 23.09.2021.
//

import UIKit

class FavoriteCatViewController: UIViewController {

    @IBOutlet weak var favoriteCatsCollectionView: UICollectionView!
    
    var favoriteCatsArray = [CatModel]()
    
    let countCells = 2
    let offset: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCatsCollectionView.delegate = self
        favoriteCatsCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.favoriteCatsArray = CatStorage.shared.getObject()
        self.favoriteCatsCollectionView.reloadData()
    }
}

extension FavoriteCatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCatsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteCatCell", for: indexPath) as! FavoriteCatCollectionViewCell
        cell.initCell(data: favoriteCatsArray[indexPath.row])
        cell.favoriteCatImage.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let singleCatController = self.storyboard?.instantiateViewController(identifier: "favoriteCatView") as! SingleFavoriteCatViewController
        let item = indexPath.item
        singleCatController.favoriteCatModel = self.favoriteCatsArray[indexPath.row]
        singleCatController.onDelete = { [weak self]  in
            guard let self = self else { return }
            
            self.favoriteCatsArray.remove(at: item)
            collectionView.deleteItems(at: [indexPath])
        }
        
        self.present(singleCatController, animated: true, completion: nil)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = favoriteCatsCollectionView.frame

        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell

        let spacing = CGFloat(countCells + 1) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - spacing)
    }
}

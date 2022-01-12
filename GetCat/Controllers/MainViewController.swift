//
//  MainViewController.swift
//  GetCat
//
//  Created by Вадим Брацюн on 21.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var catsCollectionView: UICollectionView!
    
    var array = [CatModel]()
    
    let countCells = 2
    let offset: CGFloat = 2.0
    
    var isLoading = false
    
    var loadingView: LoadingReusableView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let loadingReusableNib = UINib(nibName: "LoadingReusableView", bundle: nil)
        catsCollectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "loadingReusableId")
        catsCollectionView.delegate = self
        catsCollectionView.dataSource = self
        
        ApiManager.shared.catParsing { [weak self] newModel in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.array.append(newModel)
                self.catsCollectionView.reloadData()
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "catCell", for: indexPath) as! CatCollectionViewCell
        
        cell.updateCell(data: self.array[indexPath.row])
        cell.catImage.layer.cornerRadius = 8
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let singleCatController = self.storyboard?.instantiateViewController(identifier: "SingleCat") as! SingleCatController
        
        singleCatController.catModel = self.array[indexPath.row]
        
        self.present(singleCatController, animated: true, completion: nil)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "loadingReusableId", for: indexPath) as! LoadingReusableView
            loadingView = aFooter
            loadingView?.backgroundColor = UIColor.clear
            return aFooter
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if ((catsCollectionView.contentOffset.y + catsCollectionView.frame.size.height) >= catsCollectionView.contentSize.height)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                ApiManager.shared.catParsing { [weak self] newModel in
                    guard let self = self else { return }
                    self.array.append(newModel)
                    self.catsCollectionView.reloadData()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = catsCollectionView.frame

        let widthCell = frameCV.width / CGFloat(countCells)
        let heightCell = widthCell

        let spacing = CGFloat(countCells + 1) * offset / CGFloat(countCells)
        return CGSize(width: widthCell - spacing, height: heightCell - spacing)
    }
}


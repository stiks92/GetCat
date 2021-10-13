//
//  ImageSaver.swift
//  GetCat
//
//  Created by Вадим Брацюн on 23.09.2021.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    static let shared = ImageSaver()
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}

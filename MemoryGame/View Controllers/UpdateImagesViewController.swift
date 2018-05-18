//
//  UpdateImagesViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 18/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class UpdateImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var imageCollection: UICollectionView!
    var currentImages:[UIImage]!
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadImages()
        self.imageCollection.dataSource=self
        self.imageCollection.delegate=self
    }
    func reloadImages() {
        if let data = UserDefaults.standard.object(forKey:StaticValues.imagesNameMemory) as? Data,
            let images = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UIImage] {
            self.currentImages=images
        }
        else
        {
            self.currentImages=StaticValues.defaultImages
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "image", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = self.currentImages[indexPath.item]
        return imageViewCell
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
}


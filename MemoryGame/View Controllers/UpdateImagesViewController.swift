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
        self.imageCollection.dataSource=self
        self.imageCollection.delegate=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadImages()
    }
    func reloadImages() {
        if let data = UserDefaults.standard.object(forKey:StaticValues.IMAGES_NAME_FILE) as? Data,
            let images = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UIImage] {
            self.currentImages=images
        }
        else
        {
            self.currentImages=StaticValues.DEFAULTS_IMAGES
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "update image cell", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = self.currentImages[indexPath.item]
        return imageViewCell
    }
    
}


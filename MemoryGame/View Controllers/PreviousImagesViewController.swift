//
//  PreviousImagesViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class PreviousImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var imageIndex:Int!
    let storage = Storage()
    var prevoiusImages:[UIImage]!
    var currentImages:[UIImage]!
    @IBOutlet weak var imageCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prevoiusImages = reloadImages(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE)
        self.currentImages = reloadImages(for: StaticValues.IMAGES_NAME_FILE)
        self.imageCollection.delegate = self
        self.imageCollection.dataSource = self
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func reloadImages(for key:String)->[UIImage] {
        if let images = storage.ReloadSavedImages(for: key)
        {
            return images
        }
        else
        {
            return [UIImage]() //StaticValues.DEFAULTS_IMAGES//
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.prevoiusImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Previous Image Cell", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = self.prevoiusImages[indexPath.item]
        return imageViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newImage = self.prevoiusImages[indexPath.item]
        self.currentImages[self.imageIndex] = newImage
        storage.SaveImages(for: StaticValues.IMAGES_NAME_FILE,with: self.currentImages)
        navigationController?.dismiss(animated: true)
    }
    
}

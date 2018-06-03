//
//  PreviousImagesViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class PreviousImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var imageCollection: UICollectionView!
    
    var imageIndex:Int!
    weak var photoDelegate:ChangePhotoDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollection.delegate = self
        self.imageCollection.dataSource = self
    }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.previousImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Previous Image Cell", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = Storage.previousImages[indexPath.item]
        return imageViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = Storage.previousImages[indexPath.item]
        photoDelegate?.changePhoto(to: image, at: imageIndex)
        navigationController?.dismiss(animated: true)
    }
    
}

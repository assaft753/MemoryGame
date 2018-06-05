//
//  UpdateImagesViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 18/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//
import UIKit

class UpdateImagesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,ChangePhotoDelegate {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var defaultImagesBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollection.dataSource=self
        self.imageCollection.delegate=self
        defaultImagesBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
    }
    
    func changePhoto(to image: UIImage, at index: Int) {
        Storage.currentImages[index] = image
        print(image)
        if (!Storage.previousImages.contains(image))
        {
            Storage.previousImages.append(image)
        }
        imageCollection?.reloadData()
        DispatchQueue.global().async {
            Storage.SaveImages()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Storage.currentImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "update image cell", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = Storage.currentImages[indexPath.item]
        return imageViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Change Image", sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navCtrl = segue.destination as? UINavigationController
        let customizeCtrl = navCtrl?.visibleViewController as? CustomizeCardViewController
        customizeCtrl?.imageIndex = sender as! Int
        customizeCtrl?.photoDelegate = self
    }
    
    @IBAction func defaultImagesBtn(_ sender: UIButton) {
        Storage.currentImages = StaticValues.DEFAULTS_IMAGES
        imageCollection?.reloadData()
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
}


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
    var currentImages:[UIImage]?
    let storage = Storage()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("memory issue")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("enter will appear")
        reloadImages()
        self.imageCollection.dataSource=self
        self.imageCollection.delegate=self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.currentImages = nil
        self.imageCollection.dataSource=nil
        self.imageCollection.delegate=nil
    }
    
    func reloadImages() {
        if let images = storage.ReloadSavedImages(for: StaticValues.IMAGES_NAME_FILE)
        {
            self.currentImages=images
        }
        else
        {
            self.currentImages=StaticValues.DEFAULTS_IMAGES
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.currentImages!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "update image cell", for: indexPath) as! ImageUpdateCollectionViewCell
        imageViewCell.imageView.image = self.currentImages![indexPath.item]
        return imageViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Change Image", sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navCtrl = segue.destination as? UINavigationController
        let customizeCtrl = navCtrl?.visibleViewController as? CustomizeCardViewController
        customizeCtrl?.imageIndex=sender as! Int
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.dismiss(animated: true)
    }
}


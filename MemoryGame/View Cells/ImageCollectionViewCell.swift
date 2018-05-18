//
//  EmojiCollectionViewCell.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCell: UIImageView!
    var cubeImage:UIImage!
    var isFacedUp:Bool!
    {
        didSet
        {
            if self.isFacedUp
            {
                imageCell.backgroundColor=UIColor.clear
                imageCell.image=cubeImage
            }
            else
            {
                imageCell.backgroundColor=#colorLiteral(red: 1, green: 0, blue: 0.4, alpha: 1)
                imageCell.image=nil
            }
        }
    }
    var isMatched:Bool!
    {
        didSet{
            isUserInteractionEnabled = !isMatched
        }
    }
    
    func setCellEnable(_ toEnable:Bool)
    {
        if !isMatched
        {
            isUserInteractionEnabled = toEnable
        }
    }
    
}

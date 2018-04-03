//
//  EmojiCollectionViewCell.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class EmojiCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var emojiCell: UILabel!
    var cubeEmoji=""
    var isFacedUp=false
    {
        didSet
        {
            if self.isFacedUp
            {
                emojiCell.backgroundColor=UIColor.clear
                emojiCell.text=cubeEmoji
            }
            else
            {
                emojiCell.backgroundColor=#colorLiteral(red: 1, green: 0, blue: 0.4, alpha: 1)
                emojiCell.text=""
            }
        }
    }
    var isMatched=false
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

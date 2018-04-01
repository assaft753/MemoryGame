//
//  GameBoardViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    let MARGIN:CGFloat = 5
    var allEmojis = ["😀","😇","😎","😈","🙀","👶","🙉","🍔","🎮","🥇"]
    var emojis:[String]=[]
    var pairsCounter=10
    weak var prevCell:EmojiCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<pairsCounter
        {
            emojis.append(allEmojis[i])
        }
        emojis=emojis+emojis
        gameBoardCollectionView.delegate=self
        gameBoardCollectionView.dataSource=self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Emoji Cell", for: indexPath) as! EmojiCollectionViewCell
        let random=Int(arc4random_uniform(UInt32(emojis.count)))
        cell.cubeEmoji=emojis[random]
        emojis.remove(at: random)
        print("\(cell.cubeEmoji) \(indexPath)")
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(MARGIN, MARGIN, MARGIN, MARGIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
        
        if prevCell == nil
        {
            prevCell=cell
            prevCell?.isFacedUp=true
        }
        else if let prevIndexPath=collectionView.indexPath(for: prevCell!),prevIndexPath != indexPath
        {
            cell.isFacedUp=true
            if prevCell?.cubeEmoji == cell.cubeEmoji
            {
                prevCell?.isMatched=true
                cell.isMatched=true
                self.pairsCounter-=1
            }
            else
            {
                prevCell?.isFacedUp=false
                cell.isFacedUp=false
            }
            prevCell=nil
        }
    }
    
    private func isGameOver()->Bool
    {
        return self.pairsCounter > 0 ? false : true
    }
    
    
    
}

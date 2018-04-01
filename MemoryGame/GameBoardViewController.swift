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
    var emojiCells:[EmojiCollectionViewCell]=[]
    var pairsCounter=0
    var sections=0
    var rows=0
    var difficulty:Difficulty?
    {
        didSet
        {
            (sections,rows) = difficulty!.getSecRow()
            pairsCounter=sections*rows/2
        }
    }
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
        return sections
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Emoji Cell", for: indexPath) as! EmojiCollectionViewCell
        let random=Int(arc4random_uniform(UInt32(emojis.count)))
        cell.cubeEmoji=emojis[random]
        emojis.remove(at: random)
        emojiCells.append(cell)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return rows
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(MARGIN, MARGIN, MARGIN, MARGIN)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell=collectionView.cellForItem(at: indexPath) as! EmojiCollectionViewCell
        self.compareHandler(compareTo: cell,with: indexPath)
        
    }
    
    private func segueTo()
    {
        if isGameOver()
        {
            performSegue(withIdentifier: "Game Over", sender: nil)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let endGameController=segue.destination as! FinishViewController
        endGameController.difficulty=self.difficulty
    }
    
    private func isGameOver()->Bool
    {
        return self.pairsCounter > 0 ? false : true
    }
    
    private func compareHandler(compareTo cell:EmojiCollectionViewCell,with indexPath:IndexPath)
    {
        cell.isFacedUp=true
        for emojicell in emojiCells
        {
            emojicell.setFacedUp()
            emojicell.setMatched()
        }
        if prevCell == nil
        {
            prevCell=cell
        }
        else if let prevIndexPath=self.gameBoardCollectionView.indexPath(for: prevCell!),prevIndexPath != indexPath
        {
            
            if self.prevCell?.cubeEmoji == cell.cubeEmoji
            {
                self.prevCell?.isMatched=true
                cell.isMatched=true
                self.pairsCounter-=1
                segueTo()
            }
            else
            {
                self.prevCell?.isFacedUp=false
                cell.isFacedUp=false
            }
            self.prevCell=nil
            
        }
    }
}


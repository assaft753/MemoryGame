//
//  GameBoardViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class GameBoardViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var userName:String?
    let TIME_LEFT = 60
    var timeLeft=0
    var timer:Timer!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!{
        didSet{
            userNameLabel.text = userName
        }
    }
    @IBOutlet weak var gameBoardCollectionView: UICollectionView!
    let MARGIN:CGFloat = 5
    var allEmojis = ["😀","😇","😎","😈","🙀","👶","🙉","🍔","🎮","🥇"]
    var emojis:[String]=[]
    var emojiCells:[EmojiCollectionViewCell]=[]
    var pairsCounter=0
    var sections=0
    var rows=0
    var difficulty:Difficulty?
    weak var prevCell:EmojiCollectionViewCell?
    
    func initiateGameBoardValues()
    {
        (sections,rows) = difficulty!.getSecRow()
        pairsCounter=sections*rows/2
        timerLabel.text = "\(TIME_LEFT)"
    }
    
    @IBAction func backaButton(_ sender: UIButton) {
        navigationController?.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.timeLeft=self.TIME_LEFT
        initiateGameBoardValues()
        for i in 0..<pairsCounter
        {
            emojis.append(allEmojis[i])
        }
        emojis=emojis+emojis
        gameBoardCollectionView.delegate=self
        gameBoardCollectionView.dataSource=self
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.timer=Timer.scheduledTimer(withTimeInterval: 1, repeats: true)
        {
            [weak self] timer in
            self!.timeLeft-=1
            self!.timerLabel.text = "\(self!.timeLeft)"
            if self!.timeLeft == 0
            {
                timer.invalidate()
                let alert = UIAlertController(title: "Memory Game", message: "You Lose", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default)
                {
                    [weak self] action in
                    self?.navigationController?.dismiss(animated: true)
                })
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
        gameBoardCollectionView.delegate=nil
        gameBoardCollectionView.dataSource=nil
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
        cell.isFacedUp=false
        cell.isMatched=false
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
    
    private func isGameOver()->Bool
    {
        return self.pairsCounter > 0 ? false : true
    }
    
    private func compareHandler(compareTo cell:EmojiCollectionViewCell,with indexPath:IndexPath)
    {
        cell.isFacedUp=true
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
                self.prevCell=nil
                segueTo()
            }
            else
            {
                enableUI(false)
                DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now()+1){
                    DispatchQueue.main.sync {
                        self.prevCell?.isFacedUp=false
                        cell.isFacedUp=false
                        self.prevCell=nil
                        self.enableUI(true)
                    }
                    
                }
                
            }
            
        }
    }
    
    func enableUI(_ toEnable:Bool)
    {
        for emojicell in emojiCells
        {
            emojicell.setCellEnable(toEnable)
        }
    }
}

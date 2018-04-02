//
//  DifficultyViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 02/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    {
        didSet
        {
            userNameLabel.text=userName
        }
    }
    var userName:String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameBoardViewController=segue.destination as! GameBoardViewController
        gameBoardViewController.difficulty=Difficulty.getDifficultyBy(difficultyname: segue.identifier!)
        gameBoardViewController.userName = self.userName
    }
}

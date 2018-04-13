//
//  DifficultyViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 02/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class DifficultyViewController: UIViewController {
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
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
        easyButton.layer.cornerRadius = 10
        mediumButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameBoardViewController=segue.destination as! UINavigationController
        let temp=gameBoardViewController.visibleViewController as! GameBoardViewController
        temp.difficulty=Difficulty.getDifficultyBy(difficultyname: segue.identifier!)
        temp.userName = self.userName
    }
}

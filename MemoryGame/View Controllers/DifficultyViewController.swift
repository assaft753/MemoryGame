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

    override func viewDidLoad() {
        super.viewDidLoad()
        easyButton.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
        mediumButton.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
        hardButton.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        let gameBoardViewController = segue.destination as! GameBoardViewController
        gameBoardViewController.difficulty = Difficulty.getDifficultyBy(difficultyname: segue.identifier!)
        let backItem = UIBarButtonItem()
        backItem.title = "Difficulty"
        navigationItem.backBarButtonItem = backItem
    }
}

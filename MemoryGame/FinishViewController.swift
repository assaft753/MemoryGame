//
//  FinishViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    var difficulty:Difficulty?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let gameController=segue.destination as? GameBoardViewController
        {
            gameController.difficulty=self.difficulty
        }
    }

}

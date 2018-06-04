//
//  FinishViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func changeDifficulty(_ sender: UIButton) {
        navigationController?.dismiss(animated: true)
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

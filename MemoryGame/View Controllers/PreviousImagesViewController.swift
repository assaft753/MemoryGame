//
//  PreviousImagesViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class PreviousImagesViewController: UIViewController {
    @IBOutlet weak var chooseBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
    }

}

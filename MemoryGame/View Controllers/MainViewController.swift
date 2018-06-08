//
//  MainViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 02/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var customizeCardBtn: UIButton!
    @IBOutlet weak var highScoreBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        Storage.LoadImages()
        customizeCardBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
        highScoreBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
        playBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem = backItem
    }
}

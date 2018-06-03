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
    @IBAction func changeImages(_ sender: Any) {
        performSegue(withIdentifier: "Customize Images", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

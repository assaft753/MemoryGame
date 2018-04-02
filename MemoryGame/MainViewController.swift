//
//  MainViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 02/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userNameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameText.delegate=self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let difficultyViewController=segue.destination as! DifficultyViewController
        difficultyViewController.userName = self.userNameText.text
    }
    
}

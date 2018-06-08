//
//  FinishViewController.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 01/04/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    var time = -1
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func changeDifficulty(_ sender: UIButton) {
        saveRecord()
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    @IBAction func homeBtn(_ sender: UIButton) {
        saveRecord()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func saveRecord() {
        if userName.text != nil{
            let score = Score(name: userName.text!, time: time)
            Score.save(score: score)
        }
    }

}

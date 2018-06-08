//
//  HighScoreViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class HighScoreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var scoreTableView: UITableView!
    var scores:[Score]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scoreTableView.rowHeight = 35
        scores = Score.load()
        if scores != nil{
            print("\nAAAAAAAAAA\n")
            scoreTableView.delegate = self
            scoreTableView.dataSource = self
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Score Cell") as! ScoreTableViewCell

        if indexPath.row % 2 == 0
        {
            cell.nameLabel.text = "Sapir"
        }
        else
        {
            cell.nameLabel.text = "Assaf"
        }
        cell.rankLabel.text? = "\(indexPath.row + 1)"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Home"
        navigationItem.backBarButtonItem = backItem
    }
    
}

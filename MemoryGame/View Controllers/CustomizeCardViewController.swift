//
//  CustomizeCardViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit

class CustomizeCardViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var chooseBtn: UIButton!
    var chooseOption: String!
    let options = StaticValues.OPTIONS_PICKER
    var imageIndex:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
        chooseBtn.layer.cornerRadius = StaticValues.CORNER_RADIUS_BTN
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("\(imageIndex) kkkk")
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseOption = options[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let prevCtrl = segue.destination as! PreviousImagesViewController
        prevCtrl.imageIndex = sender as! Int
    }

    @IBAction func onClickChooseBtn(_ sender: UIButton) {
        switch chooseOption {
        case "Gallery":
            //get approval from user
            // open gallery
            break
        case "Previous images":
            performSegue(withIdentifier: "Previous Images", sender:imageIndex)
            break
        case "Download URL":
            // open textbox to insert URL
            break
        case "Take a picture":
            //get approval from user
            // open camera
            break
        default:
            break
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
}

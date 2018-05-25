//
//  CustomizeCardViewController.swift
//  MemoryGame
//
//  Created by Sapir Kaplan on 19/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import UIKit
import MobileCoreServices

class CustomizeCardViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var chooseBtn: UIButton!
    var chooseOption: String!
    let options = StaticValues.OPTIONS_PICKER
    var imageIndex:Int!
    @IBOutlet weak var chosenImage: UIImageView!
    
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
            let imagePicker = UIImagePickerController()
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                // print("in if \n")
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
                //print("in if \n")
            }
            else{ print("in else \n")}
            break
        case "Previous images":
            performSegue(withIdentifier: "Previous Images", sender:imageIndex)
            break
        case "Download URL":
            weak var urlTextField:UITextField?
            let alertDialog=UIAlertController(title: "Picture By URL", message: nil, preferredStyle: .alert)
            let cancel=UIAlertAction(title: "Cancel", style:.cancel)
            let ok=UIAlertAction(title: "OK", style: .default){ [weak self] uiAction  in
                let urlText = urlTextField!.text!
                let url=URL(string: urlText)!
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration)
                let dataTask = session.dataTask(with: url){
                    data,respond,error in
                    if error == nil
                    {
                        if let image=UIImage(data: data!)
                        {
                            StaticValues.AddImage(for: StaticValues.IMAGES_NAME_FILE, at: self!.imageIndex, image: image)
                            StaticValues.AddImage(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE, at: nil, image: image)
                            self?.navigationController?.dismiss(animated: true)
                        }
                    }
                }
                dataTask.resume()
                
            }
            alertDialog.addAction(ok)
            alertDialog.addAction(cancel)
            alertDialog.addTextField{ textField in
                urlTextField = textField
                urlTextField?.placeholder="URL"
            }
            self.present(alertDialog, animated: true)
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
    
    @objc func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        chosenImage.image = image // need to change to nevigate to updateImagesViewController with the chosen image from gallery
        
        //        if let updateImagesViewController=presentingViewController as? UpdateImagesViewController{
        //            updateImagesViewController.currentImages[imageIndex].im
        //        }
        
        navigationController?.dismiss(animated: true)
        
    }
    
    
}

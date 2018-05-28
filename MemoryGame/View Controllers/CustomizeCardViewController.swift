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
    let storage = Storage()
    var chooseOption = "Gallery"
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
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        case "Previous images":
            performSegue(withIdentifier: "Previous Images", sender:imageIndex)
        case "Download URL":
            weak var urlTextField:UITextField?
            let alertDialog = UIAlertController(title: "Picture By URL", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style:.cancel)
            let ok = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default){ [weak self] uiAction  in
                let urlText = urlTextField!.text!
                let url=URL(string: urlText)!
                let configuration = URLSessionConfiguration.default
                let session = URLSession(configuration: configuration)
                let dataTask = session.dataTask(with: url){
                    [weak self] data,respond,error in
                    if error == nil
                    {
                        if let image=UIImage(data: data!)
                        {
                            self?.storage.AddImage(for: StaticValues.IMAGES_NAME_FILE, at: self!.imageIndex, image: image)
                            self?.storage.AddImage(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE, at: nil, image: image)
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
                urlTextField?.placeholder=NSLocalizedString("URL", comment: "")
            }
            self.present(alertDialog, animated: true)
        case "Take a picture":
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePicker.sourceType = .camera
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        picker.dismiss(animated: true){ [weak self] ()  in
            let alert = UIAlertController(title: nil, message: "please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            self?.present(alert, animated: true, completion: nil)
            DispatchQueue.global().async { [weak self] in
                print("add image")
                self?.storage.AddImage(for: StaticValues.IMAGES_NAME_FILE, at: self?.imageIndex, image: image)
                print("finish add image")
                print("add prev")
                self?.storage.AddImage(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE, at: nil, image: image)
                print("finish add prev")
                DispatchQueue.main.sync { [weak self] in
                    print("finish")
                    self?.dismiss(animated: false)
                    self?.navigationController?.dismiss(animated: true)
                }
            }
        }
        //self.dismiss(animated: true)
        //
        //
        
    }
}

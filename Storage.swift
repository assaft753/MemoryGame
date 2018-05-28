//
//  Storage.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 28/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import Foundation
import UIKit

struct Storage {
    
    func ReloadSavedImages(for key:String)-> [UIImage]?
    {
        var data:Data?
        data = UserDefaults.standard.object(forKey:key) as? Data
        if data != nil,
            let images = NSKeyedUnarchiver.unarchiveObject(with: data!) as? [UIImage] {
            data = nil
            return images
        }
        else
        {
            return nil
        }
    }
    
    func SaveImages(for key:String, with images:[UIImage])
    {
        var data:Data? = NSKeyedArchiver.archivedData(withRootObject: images)
        UserDefaults.standard.set(data, forKey: key)
        data = nil
    }
    
    func AddImage(for key:String,at index:Int?,image:UIImage)
    {
        var imagesArr:[UIImage]?
        if key == StaticValues.PREVIOUS_IMAGES_NAME_FILE
        {
            imagesArr = self.ReloadSavedImages(for: key)
            if imagesArr != nil
            {
                imagesArr!.append(image)
                self.SaveImages(for: key, with: imagesArr!)
            }
            else
            {
                imagesArr = [image]
                self.SaveImages(for: key, with: imagesArr!)
            }
            
        }
        else if key == StaticValues.IMAGES_NAME_FILE
        {
            imagesArr = self.ReloadSavedImages(for: key)
            if imagesArr != nil
            {
                imagesArr![index!] = image
                self.SaveImages(for: key, with: imagesArr!)
            }
            else
            {
                imagesArr = StaticValues.DEFAULTS_IMAGES
                imagesArr![index!] = image
                self.SaveImages(for: key, with: imagesArr!)
            }
        }
        imagesArr = nil
    }
}

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
    
    static var currentImages:[UIImage]!
    static var previousImages:[UIImage]!
    
    private static func LoadSavedImages(for key:String)-> [UIImage]?
    {
        let filePath = StaticValues.BASE_URL.appendingPathComponent(key)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath.path) as? [UIImage]
    }
    
    static func LoadImages()
    {
        if let imagesCurrent = LoadSavedImages(for: StaticValues.IMAGES_NAME_FILE)
        {
            Storage.currentImages = imagesCurrent
        }
        else
        {
            Storage.currentImages = StaticValues.DEFAULTS_IMAGES
        }
        
        if let imagesPrev = LoadSavedImages(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE)
        {
            Storage.previousImages = imagesPrev
        }
        else
        {
            Storage.previousImages = [UIImage]()
        }
    }
    
    private static func SaveImages(for key:String, with images:[UIImage])
    {
        let filePath = StaticValues.BASE_URL.appendingPathComponent(key)
        NSKeyedArchiver.archiveRootObject(images, toFile: filePath.path)
    }
    
    static func SaveImages()
    {
        SaveImages(for: StaticValues.IMAGES_NAME_FILE, with: Storage.currentImages)
        SaveImages(for: StaticValues.PREVIOUS_IMAGES_NAME_FILE, with: Storage.previousImages)
    }
}

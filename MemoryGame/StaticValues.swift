//
//  StaticValues.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 18/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import Foundation
import UIKit

struct StaticValues {
    static let IMAGES_NAME_FILE = "images"
    static let RECORDS_NAME_FILE = "records"
    static let PREVIOUS_IMAGES_NAME_FILE = "previous"
    static let DEFAULTS_IMAGES = [#imageLiteral(resourceName: "Bear"), #imageLiteral(resourceName: "Dog"), #imageLiteral(resourceName: "Monkey"), #imageLiteral(resourceName: "Simba"), #imageLiteral(resourceName: "Butterfly"), #imageLiteral(resourceName: "Dolphin"), #imageLiteral(resourceName: "Duck"), #imageLiteral(resourceName: "Kangaroo"), #imageLiteral(resourceName: "Koala"), #imageLiteral(resourceName: "Tiger")]
    static let MARGIN:CGFloat = 5
    static let CORNER_RADIUS_BTN = CGFloat(8)
    static let CARD_CORNER_RADIUS = CGFloat(5)
    static let OPTIONS_PICKER = ["Gallery", "Previous images", "Download URL", "Take a picture"]
    
    static func ReloadSavedImages(for key:String)-> [UIImage]?
    {
        if let data = UserDefaults.standard.object(forKey:key) as? Data,
            let images = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UIImage] {
            return images
        }
        else
        {
            return nil
        }
    }
    
    static func SaveImages(for key:String, with images:[UIImage])
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: images)
        UserDefaults.standard.set(data, forKey: key)
    }
}

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
    static let DEFAULTS_IMAGES = [#imageLiteral(resourceName: "Bear"), #imageLiteral(resourceName: "Dog"), #imageLiteral(resourceName: "Monkey"), #imageLiteral(resourceName: "Simba"), #imageLiteral(resourceName: "Butterfly"), #imageLiteral(resourceName: "Dolphin"), #imageLiteral(resourceName: "Duck"), #imageLiteral(resourceName: "Kangaroo"), #imageLiteral(resourceName: "Koala"), #imageLiteral(resourceName: "Tiger")]
    static let MARGIN:CGFloat = 5
    static let CORNER_RADIUS_BTN = CGFloat(8)
    static let CARD_CORNER_RADIUS = CGFloat(5)
    static let OPTIONS_PICKER = ["Gallery", "Previous images", "Download URL", "Take a picture"]
}

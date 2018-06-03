//
//  ChangePhotoDelegate.swift
//  MemoryGame
//
//  Created by Assaf Tayouri on 30/05/2018.
//  Copyright © 2018 Assaf Tayouri. All rights reserved.
//

import Foundation
import UIKit

@objc public protocol ChangePhotoDelegate{
    func changePhoto(to image:UIImage,at index:Int)
}

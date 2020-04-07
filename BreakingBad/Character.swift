//
//  Character.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import Foundation
import UIKit

class Character {
    
    var image: UIImage
    var name: String
    var birthday : String
    
    init(name: String, birthday: String, image:UIImage) {
        self.image = image
        self.name = name
        self.birthday = birthday
        
    }
}

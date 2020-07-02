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
    var nickname : String
    var occupations: [String]
    var portrayed: String
    
    init(name: String, birthday: String, image: UIImage, nickname: String, occupations: [String], portrayed: String) {
        self.image = image
        self.name = name
        self.nickname = nickname
        self.birthday = birthday
        self.occupations = occupations
        self.portrayed = portrayed
    }
}

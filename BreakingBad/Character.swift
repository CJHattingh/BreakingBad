//
//  Character.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public class Character: Object {
    
    var image: UIImage? = nil
    @objc dynamic var name: String = ""
    @objc dynamic var birthday : String = ""
    @objc dynamic var nickname : String = ""
    var occupations: [String] = []
    @objc dynamic var portrayed: String = ""
    @objc dynamic var imageURL: String = ""
    
    convenience init(name: String, birthday: String, image: UIImage?, nickname: String, occupations: [String], portrayed: String, imageURL: String) {
        self.init()
        self.image = image
        self.name = name
        self.nickname = nickname
        self.birthday = birthday
        self.occupations = occupations
        self.portrayed = portrayed
        self.imageURL = imageURL
    }
}

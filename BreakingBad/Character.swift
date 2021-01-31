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

public class Occupation: Object {
    @objc dynamic var occupation: String = ""
}

public class Character: Object {
    
    let occupations = List<Occupation>()
    @objc dynamic var image: Data? = nil
    @objc dynamic var name: String = ""
    @objc dynamic var birthday : String = ""
    @objc dynamic var nickname : String = ""
    @objc dynamic var portrayed: String = ""
    @objc dynamic var imageURL: String = ""
    @objc dynamic var id: Int = 0
    
    convenience init(image: Data?, name: String, birthday:String, nickname: String, portrayed: String, imageURL: String, id: Int) {
        self.init()
        self.image = image
        self.name = name
        self.birthday = birthday
        self.nickname = nickname
        self.portrayed = portrayed
        self.imageURL = imageURL
        self.id = id
    }
}

//
//  CharacterJson.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/11/19.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import Foundation

public struct CharacterJson: Decodable {
    let name: String
    let img: String
    let birthday: String
    let nickname: String
    let occupation: [String]
    let portrayed: String
}

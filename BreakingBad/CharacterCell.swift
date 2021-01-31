//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

public class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterNicknameLabel: UILabel!
    @IBOutlet weak var characterDobLabel: UILabel!
    
     private let defaultImage = UIImage(named: "defaultImage")
    
    func setCharacter(character: Character) {
        if let image = character.image {
            characterImageView.image = UIImage(data: (image))
        } else {
            characterImageView.image = defaultImage
        }
        characterNameLabel.text = character.name
        characterNicknameLabel.text = character.nickname
        characterDobLabel.text = character.birthday
    }
}

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
    
    func setCharacter(character: Character) {        
        characterImageView.image = character.image
        characterNameLabel.text = character.name
        characterNicknameLabel.text = character.nickname
        characterDobLabel.text = character.birthday
    }
}

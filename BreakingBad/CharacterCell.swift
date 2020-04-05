//
//  CharacterCell.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func setCharacter(character: Character) {
        characterImageView.image = character.image
        characterNameLabel.text = character.name
    }
}

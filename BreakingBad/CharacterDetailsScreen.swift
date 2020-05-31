//
//  CharacterDetailsScreen.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/08.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

class CharacterDetailsScreen: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDob: UILabel!
    @IBOutlet weak var characterOccupation: UILabel!
    @IBOutlet weak var characterPortrayed: UILabel!
    
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character?.name

        characterImage.image = character?.image
        characterName.text = character?.nickname
        characterDob.text = character?.birthday
        characterOccupation.text = (character?.occupations)?.joined(separator: ", ")
        characterPortrayed.text = character?.portrayed
    }
}

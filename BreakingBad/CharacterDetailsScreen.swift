//
//  CharacterDetailsScreen.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/08.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

public class CharacterDetailsScreen: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDob: UILabel!
    @IBOutlet weak var characterOccupation: UILabel!
    @IBOutlet weak var characterPortrayed: UILabel!
    
    var character: Character?
     private let defaultImage = UIImage(named: "defaultImage")
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = character?.name
        if let image = character?.image {
            characterImage.image = UIImage(data: (image))
        } else {
            characterImage.image = defaultImage
        }
        characterName.text = character?.nickname
        characterDob.text = character?.birthday
        //characterOccupation.text = (character?.occupations)?.joined(separator: ", ")
        characterPortrayed.text = character?.portrayed
    }
}

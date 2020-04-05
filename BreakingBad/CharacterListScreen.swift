//
//  CharacterListScreen.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

class CharacterListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var characters: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        characters = createArray()
    }

    // create function here that requests data
    
    
    // use this function to assign data to and array of objects
    
    func createArray() -> [Character] {
        
        var tempCharacters: [Character] = []
        
        let charecter1 = Character(image: #imageLiteral(resourceName: "Jesse_Pinkman"), name: "Jesse Pinkman")
        
        tempCharacters.append(charecter1)
        
        return tempCharacters
    }
}

extension CharacterListScreen: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let character = characters[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as!
            CharacterCell
        
        cell.setCharacter(character: character)
        
        return cell
    }
}

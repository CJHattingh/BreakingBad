//
//  CharacterListScreen.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit

public class CharacterListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var characters: [Character] = []
    private var loading: Bool = true
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        getCharacters()
    }
    
    // Get all character data
    private func getCharacters(){
        
        var characterJson: [CharacterJson] = []
        
        let url = URL(string: "https://www.breakingbadapi.com/api/characters")!
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                characterJson = try! JSONDecoder().decode([CharacterJson].self, from: data)
                let characterList = self?.createArray(characterList: characterJson)
                self?.characters = characterList!
            }
            self?.loading = false
            DispatchQueue.main.async {
                self?.removeSpinner()
                self?.tableView.reloadData()
            }
        }
        task.resume()
        self.showSpinner()
    }
    
    // function to assign data to and array of objects    
    private func createArray(characterList : [CharacterJson]) -> [Character] {

        var tempCharacters: [Character] = []

        //loop here to create characters array
        for character in characterList {
            let imageURL = URL(string: character.img)
            var age: String = character.birthday
            
            // get age if bday not unknown
            if age != "Unknown" {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM'-'dd'-'YYY'"
                let date = dateFormatter.date(from: character.birthday)
                let now = Date()
                let birthday: Date = date!
                let calendar = Calendar.current
                let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
                age = age + " (" + String(ageComponents.year!) + ")"
            }
            do {
                let imageTry = try Data(contentsOf: imageURL!)
                let image = UIImage(data: imageTry)
                let newCharacter = Character(name: character.name, birthday: age, image: image!, nickname: character.nickname, occupations: character.occupation, portrayed: character.portrayed)
                tempCharacters.append(newCharacter)
            } catch {
                print("Image error")
            }
        }
        return tempCharacters
    }
}

extension CharacterListScreen: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        } else {
            return characters.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as!
        CharacterCell
        if !loading {
            let character = characters[indexPath.row]
            cell.setCharacter(character: character)
            return cell
        } else {
            return cell
        }
    }
    
    // Show Detail screen
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsScreen {
            destination.character = characters[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

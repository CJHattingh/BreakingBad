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
    
    private var characters: [Character] = []
    private var loading: Bool = true
    private let defaultImage = UIImage(named: "defaultImage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCharacters()
    }
    
    private func getAllCharacters(){
        
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                if let characterJson = self?.decodeData(data) {
                    guard let characterList = self?.createCharacterList(from: characterJson) else {
                        return
                    }
                    self?.characters = characterList
                }
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
    
    private func decodeData(_ data: Data) -> [CharacterJson]? {
        do {
            return try JSONDecoder().decode([CharacterJson].self, from: data)
        } catch {
            return nil
        }
    }
    
     
    private func createCharacterList(from characterList : [CharacterJson]) -> [Character] {
        var tempCharacters: [Character] = []
        for character in characterList {
            let image = defaultImage!
            let birthday: String = character.birthday
            let age = addAgeToBirthday(from: birthday)
            let newCharacter = Character(name: character.name, birthday: age, image: image, nickname: character.nickname, occupations: character.occupation, portrayed: character.portrayed)
            tempCharacters.append(newCharacter)
            if let imageURL = URL(string: character.img) {
                getImageAsync(from: newCharacter, imageUrl: imageURL)
            }
        }
        return tempCharacters
    }
    
    private func addAgeToBirthday(from birthday: String) -> String {
            if birthday != "Unknown" {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM'-'dd'-'YYY'"
                let date = dateFormatter.date(from: birthday)
                let now = Date()
                guard let formattedBirthday: Date = date else {
                    return birthday
                }
                let calendar = Calendar.current
                let ageComponents = calendar.dateComponents([.year], from: formattedBirthday, to: now)
                let age = birthday + " (" + String(ageComponents.year!) + ")"
                return age
            }
            else {
                return birthday
            }
        }
    
    private func getImageAsync(from character: Character, imageUrl: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            let characterImage = self.getImageData(imageUrl)
            character.image = characterImage!
        }
    }
    
    func getImageData(_ imageUrl: URL) -> UIImage? {
        do {
            let imageTry = try Data(contentsOf: imageUrl)
            let image = UIImage(data: imageTry)
            return image
        } catch {
            return nil
        }
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CharacterDetailsScreen {
            destination.character = characters[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

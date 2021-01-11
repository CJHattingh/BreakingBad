//
//  CharacterListScreen.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2020/04/05.
//  Copyright © 2020 Jandrè Hattingh. All rights reserved.
//

import UIKit
import RealmSwift

class CharacterListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var characters: [Character] = []
    private var loading: Bool = true
    private let defaultImage = UIImage(named: "defaultImage")
    //private var realmCharacters: Results<Character>!
    //private let realm = RealmService.shared.realm
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //realmCharacters = realm.objects(Character.self)
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
     
    private func createCharacterList(from characterList: [CharacterJson]) -> [Character] {
        var tempCharacters: [Character] = []
        for character in characterList {
            let newCharacter = createCharacter(from: character)
            tempCharacters.append(newCharacter)
            //RealmService.shared.create(newCharacter)
        }
        return tempCharacters
    }
    
    private func createCharacter(from character: CharacterJson) -> Character {
        return Character(name: character.name, birthday: addAge(to: character.birthday), image: nil, nickname: character.nickname, occupations: character.occupation, portrayed: character.portrayed, imageURL: character.img)
    }
    
    private func addAge(to birthday: String) -> String {
            if birthday != "Unknown" {
                return birthday + ageText(from: birthday)
            }
            return birthday
        }
    
    private func ageText(from birthdate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM'-'dd'-'YYY'"
        let date = dateFormatter.date(from: birthdate)
        let now = Date()
        guard let formattedBirthday: Date = date else {
            return " "
        }
        let ageComponents = Calendar.current.dateComponents([.year], from: formattedBirthday, to: now)
        return " (" + String(ageComponents.year!) + ")"
    }
    
    private func getImage(_ imageUrl: URL) -> UIImage? {
        do {
            let imageData = try Data(contentsOf: imageUrl)
            return UIImage(data: imageData)
        } catch {
            return defaultImage
        }
    }
}

extension CharacterListScreen: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if loading {
            return 1
        }
        return characters.count
        //return realmCharacters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as!
        CharacterCell
        if !loading {
            let character = characters[indexPath.row]
            //let character = realmCharacters[indexPath.row]
            if character.image == nil {
                DispatchQueue.global(qos: .userInitiated).async {
                    self.fetchImage(for: character, at: indexPath)
                }
            }
            cell.setCharacter(character: character)
            return cell
        }
        return cell
    }

    private func fetchImage(for character: Character , at indexPath: IndexPath) {
        if let URL = URL(string: character.imageURL) {
            if let image = getImage(URL) {
                character.image = image
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .none)
                }
            }
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

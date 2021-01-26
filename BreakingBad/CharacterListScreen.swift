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
    private var realmCharacters: Results<Character>!
    private let realm = RealmService.shared.realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realmCharacters = realm.objects(Character.self)
        getAllCharacters()
    }
    
    private func getAllCharacters(){
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data {
                if let characterJson = self?.decodeData(data) {
                    self?.addCharactersToRealm(from: characterJson)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }.resume()
    }
    
    private func decodeData(_ data: Data) -> [CharacterJson]? {
        do {
            return try JSONDecoder().decode([CharacterJson].self, from: data)
        } catch {
            return nil
        }
    }
     
    private func addCharactersToRealm(from characterList: [CharacterJson]) {
        for character in characterList {
            let newCharacter = createCharacter(from: character)
            addOccupations(character: newCharacter, occupations: character.occupations)
            RealmService.shared.create(newCharacter)
        }
    }
    
    private func createCharacter(from character: CharacterJson) -> Character {
        return Character(image: nil, name: character.name, birthday: addAge(to: character.birthday), nickname: character.nickname, portrayed: character.portrayed, imageURL: character.img, id: character.id)
    }
    
    private func addOccupations(character: Character, occupations: [String]) {
        let occupations = List<Occupation>()
        for occupation in occupations {
            character.occupations.append(occupation)
        }
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
    
    private func getImage(_ imageUrl: URL) -> Data? {
        do {
            let imageData = try Data(contentsOf: imageUrl)
            return imageData
        } catch {
            return nil
        }
    }
}

extension CharacterListScreen: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmCharacters.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell") as!
        CharacterCell
        let character = realmCharacters[indexPath.row]
        if character.image == nil {
            DispatchQueue.global(qos: .userInitiated).async {
                self.fetchImage(for: character, at: indexPath)
            }
            cell.setCharacter(character: character)
            return cell
        }
        return cell
    }

    private func fetchImage(for character: Character , at indexPath: IndexPath) {
        if let URL = URL(string: character.imageURL) {
            if let image = getImage(URL) {
                RealmService.shared.updateCharacter("image", id: character.id, updateValue: image)
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

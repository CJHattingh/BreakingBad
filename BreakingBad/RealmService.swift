//
//  RealmService.swift
//  BreakingBad
//
//  Created by Jandrè Hattingh on 2021/01/11.
//  Copyright © 2021 Jandrè Hattingh. All rights reserved.
//

import Foundation
import RealmSwift

public class RealmService {
    private init() {}
    static let shared = RealmService()
    
    var realm = try! Realm()
    
    public func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(error)
        }
    }
    
    public func updateCharacter(_ field: String, id: Int, updateValue: Any?) {
        let chatacter = self.findCharacter("id", value: id)
        do {
            try self.realm.write {
                chatacter.setValue(updateValue, forKey: "\(field)")
            }
        } catch {
            print(error)
        }
    }
    
    public func findCharacter(_ field: String, value: Int) -> Results<Character> {
        let predicate = NSPredicate(format: "%K = %d", field, value)
            return realm.objects(Character.self).filter(predicate)
    }
}

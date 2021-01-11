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
    
    public func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print(error)
        }
    }
    
    public func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(error)
        }
    }
}

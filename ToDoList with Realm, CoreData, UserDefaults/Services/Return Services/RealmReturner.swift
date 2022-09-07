//
//  RealmReturner.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation
import RealmSwift

class RealmReturner: Returner {
    
    private let realm = try! Realm(configuration: .defaultConfiguration)
    
    func getObjects() -> Any? {
        return realm.objects(RealmObject.self)
    }
    
    
}

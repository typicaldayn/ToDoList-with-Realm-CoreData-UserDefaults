//
//  RealmSave.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation
import RealmSwift

class RealmSaver: Saver {
    
    private let realm = try! Realm(configuration: .defaultConfiguration)
    
    func saveObjects(title: String, text: String?) {
        let object = convertToRealm(title: title, text: text)
        do {
            try realm.write{
                realm.add(object)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func delete(at index: Int) {
        let itemToDelete = realm.objects(RealmObject.self)[index]
        do {
            try realm.write{
                realm.delete(itemToDelete)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func convertToRealm(title: String, text: String?) -> RealmObject {
        let object = RealmObject()
        object.title = title
        guard text != nil else {return object}
        object.text = text
        return object
    }
}

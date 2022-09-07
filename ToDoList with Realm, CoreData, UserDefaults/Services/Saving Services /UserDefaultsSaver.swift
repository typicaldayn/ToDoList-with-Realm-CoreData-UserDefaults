//
//  UserDefaultsSave.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation

class DefaultsSaver: Saver {
    
    private var returner = DefaultsReturner()
    private let defaults = UserDefaults.standard
    private var arrayGet: [DefaultsModel] {
        returner.getObjects() as! [DefaultsModel]
    }
    private var arraySet: Data?
    
    func delete(at index: Int) {
        var objectToDelete: DefaultsModel?
        do {
            let decoder = JSONDecoder()
            let encoder = JSONEncoder()
            let data = try encoder.encode(arrayGet)
            arraySet = data
            objectToDelete = try decoder.decode(DefaultsModel.self, from: data)
            guard objectToDelete != nil else {return}
            defaults.removeObject(forKey: objectToDelete!.title)
            arraySet?.remove(at: index)
            let arrayToSet = try decoder.decode([DefaultsModel].self, from: data)
            defaults.set(arrayToSet as NSArray, forKey: "all")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func saveObjects(title: String, text: String?) {
        let newObject = DefaultsModel(text: text ?? "", title: title)
        var data = Data()
        do {
            let encoder = JSONEncoder()
            let decoder = JSONDecoder()
            data = try encoder.encode(newObject)
            arraySet?.append(data)
            guard arraySet != nil else {return}
            let arrayToSet = try decoder.decode([DefaultsModel].self, from: arraySet!)
            defaults.set(text! as NSString, forKey: title)
            defaults.set(arrayToSet as NSArray, forKey: "all")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}

//
//  UserDefaultsSave.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation

class DefaultsSaver: Saver {
    
    private let defaults = UserDefaults.standard
    private var arrayOfObjects = [Data]()
    
    func delete(at index: Int) {
        print(arrayOfObjects.count)
        let data = arrayOfObjects[index]
        var objectToDelete: DefaultsModel?
        do {
            let decoder = JSONDecoder()
            objectToDelete = try decoder.decode(DefaultsModel.self, from: data)
        } catch {
            print(error.localizedDescription)
        }
        guard objectToDelete != nil else {return}
        defaults.removeObject(forKey: objectToDelete!.title)
        arrayOfObjects.remove(at: index)
        defaults.set(arrayOfObjects as NSArray, forKey: "all")
    }
    
    func saveObjects(title: String, text: String?) {
        let newObject = DefaultsModel(text: text ?? "", title: title)
        var data = Data()
        do {
            let encoder = JSONEncoder()
            data = try encoder.encode(newObject)
        } catch {
            print(error.localizedDescription)
        }
        arrayOfObjects.append(data)
        defaults.set(text! as NSString, forKey: title)
        defaults.set(arrayOfObjects as NSArray, forKey: "all")
    }
    
}

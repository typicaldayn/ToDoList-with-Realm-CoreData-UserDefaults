//
//  Defaults returner.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 05.09.2022.
//

import Foundation

class DefaultsReturner: Returner {
    
    func getObjects() -> Any? {
        let data = UserDefaults.standard.array(forKey: "all") as? [Data]
        var arrayToReturn: [DefaultsModel] = []
        data?.forEach({ data in
            do {
                let decoder = JSONDecoder()
                let newObject = try decoder.decode(DefaultsModel.self, from: data)
                arrayToReturn.append(newObject)
            } catch {
                print(error.localizedDescription)
            }
        })
        return arrayToReturn
    }
    
}

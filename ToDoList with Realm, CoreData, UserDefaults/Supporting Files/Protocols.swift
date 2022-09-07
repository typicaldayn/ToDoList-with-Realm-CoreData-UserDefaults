//
//  Protocols.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation
import CoreData
import RealmSwift

protocol Returner {
    func getObjects() -> Any?
}

protocol Saver {
    func saveObjects(title: String, text: String?)
    func delete(at index: Int)
}




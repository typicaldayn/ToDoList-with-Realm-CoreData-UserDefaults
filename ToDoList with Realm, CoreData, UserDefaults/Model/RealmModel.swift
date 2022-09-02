//
//  RealmModel.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import Foundation
import Realm
import RealmSwift

class RealmObject: Object {
    @Persisted var title: String
    @Persisted var text: String
    @Persisted var time: Date
}

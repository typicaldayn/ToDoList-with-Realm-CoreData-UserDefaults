//
//  CoreDataObject+CoreDataProperties.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 03.09.2022.
//
//

import Foundation
import CoreData


extension CoreDataObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataObject> {
        return NSFetchRequest<CoreDataObject>(entityName: "CoreDataObject")
    }

    @NSManaged public var text: String?
    @NSManaged public var title: String?

}

extension CoreDataObject : Identifiable {

}

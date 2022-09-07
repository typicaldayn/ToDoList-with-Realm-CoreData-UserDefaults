//
//  CoreDataReturner.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 03.09.2022.
//

import Foundation
import CoreData
import UIKit

class CoreDataReturner: Returner {
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getObjects() -> Any? {
        do {
            var objects: [CoreDataObject]
            objects = try context.fetch(CoreDataObject.fetchRequest())
            return objects
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
}

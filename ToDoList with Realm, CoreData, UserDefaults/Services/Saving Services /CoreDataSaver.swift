//
//  CoreDataSave.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import CoreData
import UIKit

class CoreDataSaver: Saver {
    
    private var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveObjects(title: String, text: String?) {
        let object = CoreDataObject(context: context)
        object.title = title
        object.text = text
        do {
            try context.save()
        } catch let error as NSError {
            context.rollback()
            print(error.localizedDescription)
        }
    }
    
    func delete(at index: Int) {
        do {
            let objects = try context.fetch(CoreDataObject.fetchRequest())
            context.delete(objects[index])
            try context.save()
        } catch let error as NSError {
            context.rollback()
            print(error.localizedDescription)
        }
    }
}

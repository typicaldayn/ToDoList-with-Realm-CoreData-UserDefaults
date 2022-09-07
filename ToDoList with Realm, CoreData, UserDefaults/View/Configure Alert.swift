//
//  Configure Alert.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 06.09.2022.
//

import Foundation
import UIKit

class ConfigureAlert {
    
    private var realmSaver = RealmSaver()
    private var coreDataSaver = CoreDataSaver()
    private var defaultsSaver = DefaultsSaver()
    
    func createAlert(table: UITableView) -> UIAlertController {
        var textFieldTitle = UITextField()
        var textFieldText = UITextField()
        let alert = UIAlertController(title: "New object", message: "Sure want to create new object?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak self] action in
            if textFieldTitle.text != "" {
                let operationQ = OperationQueue()
                let block = BlockOperation {
                    DispatchQueue.main.async {
                        self?.realmSaver.saveObjects(title: textFieldTitle.text!, text: textFieldText.text)
                        self?.coreDataSaver.saveObjects(title: textFieldTitle.text!, text: textFieldText.text)
                        self?.defaultsSaver.saveObjects(title: textFieldTitle.text!, text: textFieldText.text)
                    }
                }
                operationQ.addOperation(block)
                operationQ.waitUntilAllOperationsAreFinished()
                DispatchQueue.main.async {
                    table.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            alert.dismiss(animated: true)
        }))
        alert.addTextField { textField in
            textField.placeholder = "Object title"
            textFieldTitle = textField
            if textField.text != nil && textField.text != "" {
                textFieldTitle.text = textField.text
            }
        }
        
        alert.addTextField { textField in
            textField.placeholder = "Object text"
            textFieldText = textField
            if textField.text != nil && textField.text != "" {
                textFieldText.text = textField.text
            }
        }
        return alert
    }
    
}

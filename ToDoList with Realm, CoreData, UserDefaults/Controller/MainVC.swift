//
//  ViewController.swift
//  ToDoList with Realm, CoreData, UserDefaults
//
//  Created by Stas Bezhan on 02.09.2022.
//

import UIKit
import RealmSwift

class MainVC: UIViewController {
    
    //Dependecies
    private var realmReturner = RealmReturner()
    private var realmSaver = RealmSaver()
    private var realmObjects: Results<RealmObject>? {
        get {
            guard let objects = realmReturner.getObjects() as? Results<RealmObject> else {return nil}
            return objects
        }
    }
    private var coreDataSaver = CoreDataSaver()
    private var coreDataReturner = CoreDataReturner()
    private var defaultsReturner = DefaultsReturner()
    private var defaultsSaver = DefaultsSaver()
    private var alertConfig = ConfigureAlert()
    
    @IBOutlet weak var toDoObjectsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toDoObjectsTable.delegate = self
        toDoObjectsTable.dataSource = self
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        print(defaultsReturner.getObjects())
        print(realmReturner.getObjects())
        print(coreDataReturner.getObjects())
        self.present(alertConfig.createAlert(table: toDoObjectsTable), animated: true)
    }
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objects = coreDataReturner.getObjects() as? [CoreDataObject] else {return 0}
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell") else {return UITableViewCell()}
        guard let coreDataObjects = coreDataReturner.getObjects() as? [CoreDataObject] else {return UITableViewCell()}
        cell.textLabel?.text = coreDataObjects[indexPath.row].title
        cell.detailTextLabel?.text = coreDataObjects[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard coreDataReturner.getObjects() is [CoreDataObject] else {return}
            guard realmReturner.getObjects() != nil else {return}
            guard defaultsReturner.getObjects() != nil else {return}
            coreDataSaver.delete(at: indexPath.row)
            realmSaver.delete(at: indexPath.row)
            defaultsSaver.delete(at: indexPath.row)
            toDoObjectsTable.reloadData()
        }
    }
}

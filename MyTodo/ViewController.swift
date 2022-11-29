//
//  ViewController.swift
//  MyTodo
//
//  Created by Musfick Jamil on 29/11/22.
//

import RealmSwift
import UIKit

class TodoListItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var date: Date = Date()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!
    private let realm = try! Realm()
    private var data = [TodoListItem()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = realm.objects(TodoListItem.self).map({$0})
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Nevigate to details todo screen
        let item = data[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "read") as? ReadViewController else {
            return
        }
        
        vc.item = item
        vc.deletionHandler = {[weak self] in
            self?.refresh()
        }
        vc.title = item.title
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.navigationController?.pushViewController(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func didTapAddButton(){
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "create") as? CreateViewController else {
            return
        }
        
        vc.completionHandler = {[weak self] in
            self?.refresh()
        }
        vc.title = "Add New Item"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh(){
        data = realm.objects(TodoListItem.self).map({$0})
        table.reloadData()
    }
    
    
}


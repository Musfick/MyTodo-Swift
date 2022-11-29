//
//  ReadViewController.swift
//  MyTodo
//
//  Created by Musfick Jamil on 29/11/22.
//

import RealmSwift
import UIKit

class ReadViewController: UIViewController {
    
    private let realm = try! Realm()
    public var item:TodoListItem?
    public var deletionHandler: (()-> Void)?
    
    @IBOutlet var itemLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    
    static let dateFormatter: DateFormatter = {
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .medium
        return dateFormater
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLable.text = item?.title
        dateLable.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc func didTapDelete(){
        guard let myItem = self.item else {
            return
        }
        realm.beginWrite()
        realm.delete(myItem)
        try!realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
    }

}

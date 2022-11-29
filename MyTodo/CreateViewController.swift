//
//  CreateViewController.swift
//  MyTodo
//
//  Created by Musfick Jamil on 29/11/22.
//

import RealmSwift
import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    private let realm = try! Realm()
    public var completionHandler: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        textField.delegate = self
        datePicker.setDate(Date(), animated: true)
        
        //create toolbar button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func didTapSaveButton() {
        
        let date = datePicker.date
        if let title = textField.text, !title.isEmpty {
            
            realm.beginWrite()
            //make a realm object
            let newItem = TodoListItem()
            newItem.title = title
            newItem.date = date
            realm.add(newItem)
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }
        else {
            print("Add something")
        }
        
     
    }
    

}

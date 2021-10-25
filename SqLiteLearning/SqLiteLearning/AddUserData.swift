//
//  AddUserData.swift
//  SqLiteLearning
//
//  Created by Field Employee on 10/25/21.
//

import Foundation
import UIKit

class AddUserData : UIViewController {
  var db:DBHelper = DBHelper()
 
  @IBOutlet var userID : UITextField!
  @IBOutlet var userName : UITextField!
  @IBOutlet var userAge : UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    db.insert(id: 1, name: "Swift", age: 7)
    db.insert(id: 2, name: "Objective-C", age: 25)
    db.insert(id: 3, name: "SwiftUI", age: 2)
  }
  
  @IBAction func updateDatabase() {
    guard let id = Int(userID.text!) else {
      print("Need input for user's ID")
      return
    }
    guard let name = userName.text else {
      print("Need input for user's name")
      return
    }
    guard let age = Int(userAge.text!) else {
      print("Need input for user's age")
      return
    }
    
    if (id != nil && name != nil && age != nil) {
      db.insert(id: id, name: name, age: age)
      print("Insert Sucessful!")
    } else {
      print("Failed to insert to database...")
    }
    
    performSegue(withIdentifier: "ShowTableView", sender: nil)
  }
}

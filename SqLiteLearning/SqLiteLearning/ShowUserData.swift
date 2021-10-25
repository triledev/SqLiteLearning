//
//  ViewController.swift
//  SqLiteLearning
//
//  Created by Field Employee on 10/25/21.
//

import UIKit
import SQLite3

class ShowUserData: UIViewController, UITableViewDataSource {
    
    @IBOutlet var personTable: UITableView!
    var persons: [Person] = []
    var db:DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        personTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        personTable.dataSource = self
        
        persons = db.read()
    }
    
    // Table Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! UITableViewCell
      cell.textLabel?.text = "ID : \(persons[indexPath.row].id) Name : \(persons[indexPath.row].name) Age : \(persons[indexPath.row].age)"
        return cell
    }
}




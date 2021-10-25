//
//  DBHelper.swift
//  SqLiteLearning
//
//  Created by Field Employee on 10/25/21.
//

import Foundation
import SQLite3

// Create DB helper class
class DBHelper {
    
    let dbPath : String = "LearningDB.sqlite"
    var db : OpaquePointer? // Opaque pointers are used to represent C pointers.
    
    init() {
        db = openDatabase()
        createTable()
        print("Database path: -----> \(dbPath)")
    }
    
    func openDatabase() -> OpaquePointer? {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
      
        
        print(fileURL)
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening DB")
        } else {
          
            print("Sucessfully openned connection at \(dbPath)")
        }
        return db
    }
    
    func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS person (Id INTEGER PRIMARY KEY, name TEXT, age INTEGER);"
        
        var createTableStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(createTableStatement) == SQLITE_OK {
                print("Person table created!")
            } else {
                print("Not able to create a person table.")
            }
            
        } else {
            print("Create table failed.")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    // Insert data into table
    func insert(id: Int, name: String, age: Int) {
        let insertQuery = "INSERT INTO person (Id, name, age) VALUES (?, ?, ?);"
        var insertStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(age))
            
            if sqlite3_step(insertStatement) == SQLITE_OK {
                print("Sucessfully inserted row")
            } else {
                print("Could not insert record")
            }
            
        } else {
            print("Insert statement failed......")
        }
    }
    
    // Read table
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person"
        var queryStatement : OpaquePointer? = nil
        var persons : [Person] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let age = sqlite3_column_int(queryStatement, 2)
                
                persons.append(Person(id: Int(id), name: name, age: Int(age)))
                print("Query results : ----------- ")
                print("\(id) | \(name) | \(age)")
            }
        } else {
            print("Operation failed...")
        }
        sqlite3_finalize(queryStatement)
        return persons
    }
}

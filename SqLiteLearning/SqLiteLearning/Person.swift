//
//  Person.swift
//  SqLiteLearning
//
//  Created by Field Employee on 10/25/21.
//

class Person {
    var name : String = ""
    var age : Int = 0
    var id : Int = 0
    
    init(id: Int, name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}

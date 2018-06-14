//
//  ToDo.swift
//  WinstonToDoList
//
//  Created by Winston Castillo on 6/13/18.
//  Copyright © 2018 Winston Castillo. All rights reserved.
//

import UIKit


struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?

    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter ()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
    return formatter
    } ()

    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveUrl = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist")


    static func loadToDos() -> [ToDo]? {
        guard let codedToDos = try? Data(contentsOf: ArchiveUrl) else { return nil }
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "To Do One", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "To Do Two", isComplete: false, dueDate: Date(), notes: "Notes 1")
        let todo3 = ToDo(title: "To Do Three", isComplete: false, dueDate: Date(), notes: "Notes 1")
        return [todo1, todo2, todo3]
    }

    static func saveToDos(_ todos:[ToDo]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(todos)
        try? codedToDos?.write(to: ArchiveUrl, options: .noFileProtection)
    }
    

}




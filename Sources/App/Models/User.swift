//
//  User.swift
//  App
//
//  Created by Samantha Gatt on 12/20/18.
//

import Vapor
import FluentSQLite

final class User: Content, SQLiteModel, Migration, Parameter {
    
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
    
    var id: Int?
    var username: String
}

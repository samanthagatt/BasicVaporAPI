//
//  User.swift
//  App
//
//  Created by Samantha Gatt on 12/20/18.
//

import Vapor
import FluentPostgreSQL

final class User: Content, PostgreSQLModel, Migration {
    
    init(id: Int? = nil, username: String) {
        self.id = id
        self.username = username
    }
    
    var id: Int?
    var username: String
}

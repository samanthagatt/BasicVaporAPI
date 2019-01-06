//
//  Pokemon.swift
//  App
//
//  Created by Samantha Gatt on 1/2/19.
//

import Vapor
import FluentPostgreSQL

final class Pokemon: PostgreSQLModel, Content, Migration, Parameter {
    
    init(id: Int? = nil, name: String, level: String, userID: User.ID) {
        self.id = nil
        self.name = name
        self.level = level
        self.userID = userID
    }
    
    var id: Int?
    var name: String
    var level: String
    var userID: User.ID // Typealias for Int
    
    var user: Parent<Pokemon, User> {
        return parent(\.userID)
    }
}

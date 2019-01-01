//
//  UserController.swift
//  App
//
//  Created by Samantha Gatt on 12/20/18.
//

import Vapor

final class UserController {
    
    /**
     Fetches all users stored in FluentSQLite database and renders users.leaf
     
     - Parameter req: The `Request` that will be passed into the function when this closure is called
     */
    func list(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    /**
     Creates a new instance of User and redirects to /users
     
     Should be used on POST routes since it expects data in the form of a `User` (i.e. a username key with a `Sring` value)
     */
    func create(_ req: Request) throws -> Future<User> {
        // .decode() resolves to a Future<User> so you need to map/flatMap to "unwrap" to a plain User
        return try req.content.decode(User.self).flatMap() { user -> Future<User> in
            // Saves the user and returns a Future<User>
            return user.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self).flatMap() { user in
            return try req.content.decode(User.self).flatMap() { newUser in
                user.username = newUser.username
                return user.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(User.self).flatMap() { user in
            return user.delete(on: req)
        }.transform(to: .ok)
    }
}

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
    func list(_ req: Request) throws -> Future<View> {
        return User.query(on: req).all().flatMap(){ users -> Future<View> in
            let data = ["users": users]
            return try req.view().render("users", data)
        }
    }
    
    /**
     Creates a new instance of User and redirects to /users
     
     Should be used on POST routes since it expects data in the form of a `User` (i.e. a username key with a `Sring` value)
     */
    func create(_ req: Request) throws -> Future<Response> {
        // .decode() resolves to a Future<User> so you need to map/flatMap to "unwrap" to a plain User
        return try req.content.decode(User.self).flatMap() { user -> Future<Response> in
            // Saves the user
            // map() and flatMap() themselves resolve to Futures and we use a map/flatmap below, so flatMap() was used above
            return user.save(on: req).map() { _ -> Response in
                // Final goal is to redirect to /users which resolves to a Response (NOT a Future<Response>) so .map() is used above
                return req.redirect(to: "users")
            }
        }
    }
}

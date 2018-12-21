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
            return try req.view().render("crud", data)
        }
    }
    
    /**
     Creates a new instance of User and redirects to /users
     
     Should be used on POST routes since it expects data in the form of a `User` (i.e. a username key with a `Sring` value)
     
     - Parameter req: The `Request` that will be passed into the function when this closure is called
     */
    func create(_ req: Request) throws -> Future<Response> {
        // .decode() resolves to a Future<User> so you need to map/flatMap to "unwrap" to a plain User
        return try req.content.decode(User.self).flatMap() { user in
            // Saves the user
            // map() and flatMap() themselves resolve to Futures and we use a map/flatmap below, so flatMap() was used above
            return user.save(on: req).map() { _ in
                // Final goal is to redirect to /users which resolves to a Response (NOT a Future<Response>) so .map() is used above
                return req.redirect(to: "/users")
            }
        }
    }
    
    /**
     Updates an existing User instance's username property
     
     Redirects back to /users
     
     - Parameter req: The `Request` that will be passed into the function when this closure is called
     */
    func update(_ req: Request) throws -> Future<Response> {
        // Gets user id from first parameter in url
        return try req.parameters.next(User.self).flatMap() { user in
            // Decodes the new username from the url request's content
            return try req.content.decode(UserForm.self).flatMap() { userForm in
                // Sets the user's username
                user.username = userForm.username
                // Saves the user
                return user.save(on: req).map() { _ in
                    // Redirects to /users
                    return req.redirect(to: "/users")
                }
            }
        }
    }
    
    /**
     Deletes user
     
     - Parameter req: The `Request` that will be passed into the function when this closure is called
     */
    func delete(_ req: Request) throws -> Future<Response> {
        // Gets user id from first paramater in url
        return try req.parameters.next(User.self).flatMap() { user in
            // Deletes user from database
            return user.delete(on: req).map() { _ in
                // Redirects to /users
                return req.redirect(to: "/users")
            }
        }
    }
}

import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    router.get("users") { req -> Future<View> in
        return User.query(on: req).all().flatMap(){ users -> Future<View> in
            let data = ["users": users]
            return try req.view().render("users", data)
        }
    }
    
    router.post("users") { req -> Future<Response> in
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

import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Renders welcome.leaf on main page
    router.get { req -> Future<View> in
        return try req.view().render("welcome")
    }
    
    // Passes data to leaf template to be displayed
    router.get("whoami") { req -> Future<View> in
        let me = Developer(name: "Samantha", age: 22)
        return try req.view().render("whoami", me)
    }
}


// MARK: - Content types

struct Developer: Content {
    let name: String
    let age: Int
}

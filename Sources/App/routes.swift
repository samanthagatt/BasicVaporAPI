import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // Renders welcome.leaf on main page
    router.get { req -> Future<View> in
        return try req.view().render("welcome")
    }
}


// MARK: - Content types

struct NameInfo: Content {
    let name: String
}

struct NameResponse: Content {
    let response: NameInfo
}

struct CountInfo: Content {
    let count: Int
}

struct UserInfo: Content {
    let name: String
    let age: Int
}

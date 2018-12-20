import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    router.get("hello", "vapor") { _ in
        return "Hello, Vapor!"
    }
    
    router.get("hello", String.parameter) { req -> String in
        let name = try req.parameters.next(String.self)
        return "Hello, \(name)!"
    }
    
    router.post(NameInfo.self, at: "info") { req, nameInfo in
        return NameResponse(response: nameInfo)
    }
    
    router.get("date") { _ -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: Date())
    }
    
    router.get("count", Int.parameter) { req -> CountInfo in
        let count = try req.parameters.next(Int.self)
        return CountInfo(count: count)
    }
    
    router.post(UserInfo.self, at: "user-info") { req, userInfo in
        return "Hello, your name is \(userInfo.name), and you are \(userInfo.age) years old"
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

import Vapor

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
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}


// MARK: - Content types

struct NameInfo: Content {
    let name: String
}

struct NameResponse: Content {
    let response: NameInfo
}

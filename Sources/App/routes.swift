import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    let userController = UserController()
    router.get("users", use: userController.list)
    router.post("users", use: userController.create)
    router.patch("updateUsername", User.parameter, use: userController.update)
    router.delete("user", User.parameter, use: userController.delete)
}

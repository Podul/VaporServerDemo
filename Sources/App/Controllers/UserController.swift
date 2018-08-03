//
//  UserController.swift
//  App
//
//  Created by Podul on 2018/7/25.
//

import Vapor

class UserController: RouteCollection {
    func boot(router: Router) throws {
        let userGroup = router.grouped("api", "user")
        userGroup.post(use: createUser)
        userGroup.get(use: getAllUsers)
    }
    
    func createUser(_ req: Request) throws -> Future<User> {
        let user = try req.content.decode(User.self)
        return user.save(on: req)
    }
    
    func getAllUsers(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
}

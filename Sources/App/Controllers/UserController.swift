//
//  UserController.swift
//  App
//
//  Created by Podul on 2018/7/25.
//

import Vapor

class UserController: RouteCollection {
    func boot(router: Router) throws {
        router.get("user") { req in
            return "\(req)"
        }
        
        router.post("user") { req in
            
            return "\(req.parameters)"
        }
    }
}

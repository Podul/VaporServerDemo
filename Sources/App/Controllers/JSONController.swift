//
//  JSONController.swift
//  App
//
//  Created by Podul on 2018/8/1.
//

import Vapor

struct TestJSON: Content {
    let name: String
    let age: Int
}

struct Person: Content {
    let person: TestJSON
}


/// 返回json
struct JSONController: RouteCollection {
    func boot(router: Router) throws {
        router.post("json") { req -> EventLoopFuture<Person> in
            let data = try req.content.decode(TestJSON.self)
            let person = data.map({ (json)  in
                // json 里面可以拿到传入的参数
                return Person(person: json)
            })
            // 返回的值会转为json
            return person
        }
        
        router.post("exam") { (req) -> Future<String> in
            return try req.fileio().read(file: "all").map({ (data) -> String in
                let str = String(data: data, encoding: .utf8)
                return str ?? "aa"
            })
            
            
            
//            return try req.view().render("all.json").encode(for: req)
            
        }
    }
}

import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
//    Request
    router.get("hello") { req in
//        print(req.description)
        return "hello"
    }
    
    
    try router.register(collection: UserController())
    try router.register(collection: MySQLController())
    try router.register(collection: JSONController())
    try router.register(collection: SQLiteController())
    

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

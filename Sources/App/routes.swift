import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
//    Request
    router.get("hello") { req in
//        print(req.description)
        return """
        <!DOCTYPE html>
            <html>
                <body>
                    <h1>Hello World!</h1>
                </body>
            </html>
        """
    }
    
    
    
//    router.get(<#T##path: PathComponentsRepresentable...##PathComponentsRepresentable#>, use: <#T##(Request) throws -> ResponseEncodable#>)
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

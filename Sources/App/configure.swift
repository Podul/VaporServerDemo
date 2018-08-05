import FluentSQLite
import Vapor
import MySQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    /// Register providers first
    try services.register(FluentSQLiteProvider())

    /// Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    
    
    try services.register(MySQLProvider())

//    var config = DatabasesConfig()
////    config.add
//    config.add(database: mysql, as: .mysql)
//
//    services.register(config)
    
    
    // 配置全局json编码器
//    var contentConfig = ContentConfig.default()
//    let json = JSONEncoder()
//    let jsonDe = JSONDecoder()
//    
//    json.dateEncodingStrategy = .millisecondsSince1970
//    contentConfig.use(encoder: json, for: .xml)
//    contentConfig.use(decoder: jsonDe, for: .xml)
//    services.register(contentConfig)
//    HTTPMessageDecoder()
    
    
//    try router.register(collection: TestController())
    
    /// Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
        
        // 文件！！！
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
//    PlaintextRenderer
//    ViewRenderer

    services.register(middlewares)

    // Configure a SQLite database
    let sqlite = try SQLiteDatabase(storage: .memory)
    
    /// mysql
    let mysqlConfig = MySQLDatabaseConfig(hostname: "localhost", username: "root", password: "Yang19960508" , transport: .unverifiedTLS)
    let mysql = MySQLDatabase(config: mysqlConfig)

    /// Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: sqlite, as: .sqlite)
    databases.add(database: mysql, as: .mysql)
    services.register(databases)

    /// Configure migrations
    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
    migrations.add(model: UserInfos.self, database: .sqlite)
    migrations.add(model: User.self, database: .sqlite)
    migrations.add(model: LoginRequest.self, database: .mysql)
    services.register(migrations)

}

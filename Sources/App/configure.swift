import Vapor
import FluentSQLite

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    // Registers routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
        
    // Registers fluent SQLite provider
    let fluentSQLiteProvider = FluentSQLiteProvider()
    try services.register(fluentSQLiteProvider)
    
    // Initiates database service
    var databases = DatabasesConfig()
    // Adds SQLite database
    databases.add(database: try SQLiteDatabase(storage: .memory), as: .sqlite)
    // Registers database
    services.register(databases)
    
    // Initiates migration service
    var migrations = MigrationConfig()
    // Adds User model to migrations
    migrations.add(model: User.self, database: .sqlite)
    // Registers migrations
    services.register(migrations)
}

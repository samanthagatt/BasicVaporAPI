import Vapor
import Leaf
import FluentPostgreSQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    // Registers routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Registers leaf provider
    let leafProvider = LeafProvider()
    try services.register(leafProvider)
    // Sets LeafRenderer as preferred ViewRenderer
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    // Registers fluent PostgreSQL provider
    let fluentPostgreSQLProvider = FluentPostgreSQLProvider()
    try services.register(fluentPostgreSQLProvider)
    
    let postgresqlConfig = PostgreSQLDatabaseConfig(hostname: "127.0.0.1",
                                                    port: 5432,
                                                    username: "Sam",
                                                    database: "practicedb",
                                                    password: nil)
    
    // Registers database
    services.register(postgresqlConfig)
    
    // Initiates migration service
    var migrations = MigrationConfig()
    // Adds User model to migrations
    migrations.add(model: User.self, database: .psql)
    // Registers migrations
    services.register(migrations)
}

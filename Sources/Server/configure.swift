import Vapor
import FluentMySQL
import Authentication

public func configure(
    _ config: inout Config,
    _ env: inout Environment,
    _ services: inout Services) throws
{
  
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    let serverConfiure = NIOServerConfig.default(hostname: "0.0.0.0", port: 3200)
    services.register(serverConfiure)
    
    // Configure the rest of your application here
    let directoryConfig = DirectoryConfig.detect()
    services.register(directoryConfig)
    
    // Database
    try services.register(FluentMySQLProvider())
    try services.register(MySQLProvider())
    
    // Configure the auth provider
    try services.register(AuthenticationProvider())
    
    let sqlServerConfig = MySQLDatabaseConfig(
        hostname: "45.84.1.115",
        port: 3306,
        username: "serv2",
        password: "1111",
        database: "serv2"
    )
    let sqlDatabase = MySQLDatabase(config: sqlServerConfig)
    
    var databases = DatabasesConfig()
    databases.add(database: sqlDatabase, as: .mysql)
    services.register(databases)
    
    // Create models
    var migrations = MigrationConfig()
    migrations.add(model: Customer.self, database: .mysql)
    migrations.add(model: Client.self, database: .mysql)
    migrations.add(model: Cemetery.self, database: .mysql)
    migrations.add(model: Employee.self, database: .mysql)
    migrations.add(model: FuneralAgency.self, database: .mysql)
    migrations.add(model: MemorialHall.self, database: .mysql)
    migrations.add(model: Morgue.self, database: .mysql)
    migrations.add(model: Order.self, database: .mysql)
    migrations.add(model: ProductDepartment.self, database: .mysql)
    migrations.add(model: Transport.self, database: .mysql)
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: Todo.self, database: .mysql)
    migrations.add(model: Token.self, database: .mysql)
    services.register(migrations)
}

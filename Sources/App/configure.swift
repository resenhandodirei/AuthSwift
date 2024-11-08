import Fluent
import FluentPostgresDriver
import Leaf
import Vapor

public func configure(_ app: Application) throws {
    // Criando a configuração do banco de dados usando SQLPostgresConfiguration
    let databaseConfig = SQLPostgresConfiguration(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? 5432,
        username: Environment.get("DATABASE_USERNAME") ?? "user",
        password: Environment.get("DATABASE_PASSWORD") ?? "password",
        database: Environment.get("DATABASE_NAME") ?? "authdb"
    )

    // Usando a configuração moderna do PostgreSQL
    app.databases.use(.postgres(configuration: databaseConfig), as: .psql)

    // Registra as migrações
    app.migrations.add(CreateTodo())
    app.migrations.add(CreateUser())

    // Configura o Leaf para templates
    app.views.use(.leaf)

    // Registra as rotas
    try routes(app)
}


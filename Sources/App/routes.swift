import Fluent
import Vapor

func routes(_ app: Application) throws {
    // Rota padrão para a página inicial
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    // Rota de exemplo "hello"
    app.get("hello") { req async -> String in
        "Hello, world!"
    }

    // Registra o controlador `TodoController`
    try app.register(collection: TodoController())

    // Registra o controlador `UserController` para gerenciar as rotas de autenticação
    try app.register(collection: UserController())
}


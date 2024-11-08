//
//  UserController.swift
//  AuthApp
//
//  Created by Larissa Martins Correa on 08/11/24.
//

import Vapor
import Fluent
import Crypto // Certifique-se de que está usando a biblioteca correta para hashing

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoute = routes.grouped("users")
        usersRoute.post("register", use: register)
        usersRoute.post("login", use: login)
    }

    func register(req: Request) throws -> EventLoopFuture<User> {
        let user = try req.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password) // Hash da senha
        return user.save(on: req.db).map { user }
    }

    func login(req: Request) throws -> EventLoopFuture<String> {
        let loginData = try req.content.decode(LoginRequest.self)

        // Busca o usuário pelo nome de usuário
        return User.query(on: req.db)
            .filter(\.$username == loginData.username)
            .first()
            .unwrap(or: Abort(.unauthorized))
            .flatMapThrowing { user in
                // Verifica se a senha informada corresponde ao hash salvo
                guard try Bcrypt.verify(loginData.password, created: user.password) else {
                    throw Abort(.unauthorized)
                }
                // Retorna uma mensagem de sucesso ou token (exemplo simples)
                return "Login bem-sucedido"
            }
    }
}

struct LoginRequest: Content {
    let username: String
    let password: String
}


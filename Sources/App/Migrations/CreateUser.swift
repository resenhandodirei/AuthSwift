//
//  CreateUser.swift
//  AuthApp
//
//  Created by Larissa Martins Correa on 08/11/24.
//

struct CreateUser: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("email", .string, .required)
            .unique(on: "email")
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("users").delete()
    }
}

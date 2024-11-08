//
//  User.swift
//  AuthApp
//
//  Created by Larissa Martins Correa on 08/11/24.
//


import Vapor
import Fluent
import FluentPostgresDriver

final class User: Model, Content {
    static let schema = "users"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String

    @Field(key: "email")
    var email: String

    init() {}

    init(id: UUID? = nil, username: String, password: String, email: String) {
        self.id = id
        self.username = username
        self.password = password
        self.email = email
    }
}


//
//  File.swift
//  
//
//  Created by user on 12/12/2019.
//

import Foundation
import Vapor
import FluentMySQL
import Crypto
import Random

final public class UserController: RouteCollection {
    public func boot(router: Router) throws {
        router.post(Employee.RegisterForm.self, at: "register", use: register)
        router.post(Employee.Login.self, at: "login", use: login)
        router.post(Order.OrderForm.self, at: "ordering", use: ordering)
        router.get("all", use: getting)
        
        let authRouter = Employee.tokenAuthMiddleware()
        router.grouped(authRouter).post("logout", use: logout)
    }
    private func register(_ req :Request, _ regForm: Employee.RegisterForm) throws -> EventLoopFuture<Employee.Public> {
        return Employee
            .query(on: req)
            .filter(\.eMail == regForm.eMail)
            .first()
            .flatMap {
                if $0 != nil { throw ErrorResponse(Error.userAlreadyExists) }
                if !regForm.eMail.isEmail { throw ErrorResponse(Error.incorrectEmail) }
                return try Employee(registerForm: regForm)
                    .cryptoPassword(on: req)
                    .create(on: req)
                    .map { (employee) in employee.public  }
            }
    }
    
    private func ordering(_ req: Request, _ ordForm: Order.OrderForm) throws ->
        EventLoopFuture<Order.Short> {
            return Order
                .query(on: req)
                .filter(\.eMailCustomer == ordForm.eMailCustomer)
                .first()
                .flatMap {_ in
                    if !ordForm.eMailCustomer.isEmail { throw ErrorResponse(Error.incorrectEmail2)}
            
            return try Order(orderForm: ordForm)
                .create(on: req)
                .map { (order) in
                    order.short
                }
            }
    }
    
    private func getting(_ req: Request) throws -> EventLoopFuture<[Order]> {
            return Order.query(on: req).all()
    }

    
    private func login(_ req :Request, _ regForm: Employee.Login) throws -> EventLoopFuture<Token.Public> {
    return try req
        .content
        .decode(Employee.Login.self)
        .flatMap { (loginStructure) in
        return Employee
            .query(on: req)
            .filter(\.eMail == loginStructure.eMail)
            .first()
            .unwrap(or: ErrorResponse(Error.incorrectEmail))
            .flatMap { (fetchedEmployee) in
                let hasher = try req.make(BCryptDigest.self)
                if try hasher.verify(loginStructure.password, created: fetchedEmployee.password) {
                    let newToken = try URandom().generateData(count: 32).base64EncodedString()
                    let token = try Token(token: newToken, employeeId: fetchedEmployee.requireID())
                    return token.save(on: req).createPublic(for: fetchedEmployee)
                } else {
                    throw Abort(.unauthorized)
                }
        }
    }
    }
    private func logout(on req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let token = try req.requireAuthenticated(Token.self)
        return Token
            .query(on: req)
            .filter(\.id, .equal, try token.requireID())
            .delete()
            .transform(to: .ok)
    }
    
}


    




public extension UserController {
    enum Error: String, Swift.Error {
        case userAlreadyExists = "This user already exists"
        case incorrectEmail = "You entered an invalid email"
        case incorrectEmail2 = "YoU entered an invalid e-mail"
    }
}


fileprivate extension Employee {
    func cryptoPassword(on req: Request) throws -> Employee {
        var employee = self
        let hasher = try req.make(BCryptDigest.self)
        employee.password = try hasher.hash(employee.password)
        return employee
}
}


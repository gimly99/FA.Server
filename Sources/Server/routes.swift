import Vapor
import Authentication
import Crypto

public func routes(_ router: Router) throws {
    let api = router.grouped("api")
    
   
    api.post("a", Int.parameter) { (req) -> Int in
        let value = try req.parameters.next(Int.self)
        return value
    }
    
    api.post(Customer.self, at: "register") { (req, data)  in
        data
            .create(on: req)
            .always { print("database") }
            .map { return $0 }
            .always { print("request") }
    }

    
    
    
    // getting Customers
    api.get("getCustomer", Int.parameter) { (req) -> EventLoopFuture<Customer> in
        let userId = try req.parameters.next(Int.self)
        
        return User.find(userId, on: req).unwrap(or: "AHAHHA").flatMap { (user) -> EventLoopFuture<Customer> in
            return try user.customers.query(on: req).first().unwrap(or: "EBAL CUSTOMERAAAA BLYAT")
        }
    }
    // getting Employee
    api.get("getEmployee", Int.parameter) { (req) -> EventLoopFuture<Employee> in
        let userId = try req.parameters.next(Int.self)
        
        return User.find(userId, on: req).unwrap(or: "efc").flatMap { (user) -> EventLoopFuture<Employee> in
            return try user.employees.query(on: req).first().unwrap(or: "vfevr")
        }
    }

    
    
    let userRouteController = UserController()
    try userRouteController.boot(router: router)

}


extension String: Error {
    public var localizedDescription: String {
        return self
    }

}

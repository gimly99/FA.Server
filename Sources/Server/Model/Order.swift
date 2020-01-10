//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct Order{

    public var id: Int?
    public var dateee: Date
    public var idMemorialHall: Int?
    public var idFuneralAgency: Int?
    public var surnameCustomer: String
    public var nameCustomer: String
    public var patronymicCustomer: String
    public var eMailCustomer: String
    public var phoneNumberCustomer: String
    public var idClient: Int?
    public var idCemetery: Int?
    
    public init(
        id: Int? = nil,
        dateee: Date,
        idMemorialHall: Int? = nil,
        idFuneralAgency: Int,
        surnameCustomer: String,
        nameCustomer: String,
        patronymicCustomer: String,
        eMailCustomer: String,
        phoneNumberCustomer: String,
        idClient: Int,
        idCemetery: Int)
    {
        self.id = id
        self.dateee = dateee
        self.idClient = idClient
        self.nameCustomer = nameCustomer
        self.surnameCustomer = surnameCustomer
        self.patronymicCustomer = patronymicCustomer
        self.eMailCustomer = eMailCustomer
        self.phoneNumberCustomer = phoneNumberCustomer
        self.idFuneralAgency = idFuneralAgency
        self.idMemorialHall = idMemorialHall
        self.idCemetery = idCemetery
    }
}


extension Order: Content {}
extension Order: MySQLModel {}
extension Order: MySQLMigration {}

public extension Order {
    var memorialHall: Parent<Order, MemorialHall>? {
        return parent(\.idMemorialHall)
    }
    var funeralAgency: Parent<Order, FuneralAgency>? {
        return parent(\.idFuneralAgency)
    }
//    var customer: Parent<Order, Customer>? {
//        return parent(\.idCustomer)
//    }
    var client: Parent<Order, Client>? {
        return parent(\.idClient)
    }
    var cemetery: Parent<Order, Cemetery>? {
        return parent(\.idCemetery)
    }
}


//public extension EventLoopFuture where T == [Order] {
//    func buildForms(on req: Request) -> EventLoopFuture<[Order.OrderForm]> {
//        return self.map { (arrayOrder)  in
//            try arrayOrder.map { (order) -> Order.OrderForm in
//                guard
//                    let clientParent = order.client,
//                    let cementeryParent = order.cemetery,
//                    let funeralAgencyParent = order.funeralAgency
//                else { throw Abort(HTTPStatus.noContent) }
//
//
//            }
//        }
//
////        return self.flatMap { (order) in
////            guard
////                let clientParent = $0.client,
////                let cementeryParent = $0.cemetery,
////                let funeralAgencyParent = $0.funeralAgency
////            else { throw Abort(HTTPStatus.noContent) }
////
////            let pizdecCepochlaYaEbal = clientParent.get(on: req).and(cementeryParent.get(on: req).and(funeralAgencyParent.get(on: req)))
////
////            return pizdecCepochlaYaEbal.map { (ahaha) -> (Order.OrderForm) in
////                return Order.OrderForm(
////                    dateee: order.dateee,
////                    idFuneralAgency: ahaha.1.1.requireID(),
////                    surnameCustomer: order.surnameCustomer,
////                    nameCustomer: order.nameCustomer,
////                    patronymicCustomer: order.patronymicCustomer,
////                    eMailCustomer: order.eMailCustomer,
////                    phoneNumberCustomer: order.phoneNumberCustomer,
////                    idClient: ahaha.0.requireID(),
////                    idCemetery: ahaha.1.0.requireID())
////            }
////        }
//    }
//}

public extension Order {
    struct OrderForm: Content {
        public var dateee: Date
        public var idFuneralAgency: Int?
        public var surnameCustomer: String
        public var nameCustomer: String
        public var patronymicCustomer: String
        public var eMailCustomer: String
        public var phoneNumberCustomer: String
        public var idClient: Int?
        public var idCemetery: Int?
    }
    var form: OrderForm {
        return OrderForm(
            dateee: self.dateee,
            idFuneralAgency: self.idFuneralAgency,
            surnameCustomer: self.surnameCustomer,
            nameCustomer: self.nameCustomer,
            patronymicCustomer: self.patronymicCustomer,
            eMailCustomer: self.eMailCustomer,
            phoneNumberCustomer: self.phoneNumberCustomer,
            idClient: self.idClient,
            idCemetery: self.idCemetery)
    }
    
    init(orderForm: OrderForm) {
        self = Order(dateee: orderForm.dateee,
                     idFuneralAgency: orderForm.idFuneralAgency ?? 0,
                     surnameCustomer: orderForm.surnameCustomer,
                     nameCustomer: orderForm.nameCustomer,
                     patronymicCustomer: orderForm.patronymicCustomer,
                     eMailCustomer: orderForm.eMailCustomer,
                     phoneNumberCustomer: orderForm.phoneNumberCustomer,
                     idClient: orderForm.idFuneralAgency ?? 0,
                     idCemetery: orderForm.idCemetery ?? 0)
    }
}


public extension Order {
    struct Short: Content {
        let dateee: Date
        let surnameCustomer: String
        init(dateee: Date, surnameCustomer: String) {
            self.dateee = dateee
            self.surnameCustomer = surnameCustomer
        }
    }
    var short: Short {
        return Short(dateee: self.dateee, surnameCustomer: self.surnameCustomer)
    }
}

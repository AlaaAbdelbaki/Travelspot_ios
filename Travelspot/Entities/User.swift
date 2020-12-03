//
//  User.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 11/26/20.
//

import Foundation
import ObjectMapper

class User : Mappable{
    //Properties
    var id:Int?
    var firstName:String?
    var lastName:String?
    var email:String?
    var password:String?
    var token:String?
    var createdAt:Date?
    var updatedAt:Date?
    
    required init?(map: Map) {

        }
    
    func mapping(map: Map) {
        id    <- map["id"]
        firstName    <- map["firstName"]
        lastName    <- map["lastName"]
        email    <- map["email"]
        password    <- map["password"]
        token    <- map["token"]
        createdAt    <- map["createdAt"]
        updatedAt    <- map["updatedAt"]
    }
    
    
    
}

//
//  Country.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/3/20.
//

import Foundation
import ObjectMapper


class Country : Mappable{
    var id:Int?
    var name:String?
    var picture:String?
    var createdAt:Date?
    var updatedAt:Date?
    var userId:Int?
    
    required init?(map: Map) {

        }
    
    func mapping(map: Map) {
        
        id    <- map["id"]
        name    <- map["name"]
        picture    <- map["picture"]
        createdAt    <- map["createdAt"]
        updatedAt    <- map["updatedAt"]
        userId    <- map["userId"]
        }
}

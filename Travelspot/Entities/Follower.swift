//
//  Follower.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/3/20.
//

import Foundation
import ObjectMapper

class Follower : Mappable{
    var createdAt:Date?
    var updatedAt:Date?
    var followerId:Int?
    var followingId:Int?
    
    required init?(map: Map) {

        }
    
    func mapping(map: Map) {
        createdAt    <- map["createdAt"]
        updatedAt    <- map["updatedAt"]
        followerId    <- map["followerId"]
        followingId    <- map["followingId"]
        }
}

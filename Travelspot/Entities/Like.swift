//
//  Like.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 1/9/21.
//

import Foundation
import ObjectMapper

class Like : Mappable{
    
    var id:Int?
    var createdAt:Date?
    var updatedAt:Date?
    var postId:Int?
    var userId:Int?
    
    
    init(id:Int,createdAt:Date,updatedAt:Date,postId:Int,userId:Int) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postId = postId
        self.userId = userId
    }
    
    init() {
        
    }
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        userId <- map["userId"]
        postId <- map["postId"]
    }
    
    
}

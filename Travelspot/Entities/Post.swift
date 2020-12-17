//
//  Post.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/9/20.
//

import Foundation
import ObjectMapper

class Post : Mappable {
    var id:Int?
    var body:String?
    var location:String?
    var createdAt:Date?
    var updatedAt:Date?
    var tripId:Int?
    var userId:Int?
    
    required init?(map: Map) {

        }
    init(){
        
    }
    
    init(id:Int,body:String,location:String,createdAt:Date,updatedAt:Date,tripId:Int,userId:Int){
        self.id = id
        self.body = body
        self.location = location
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.tripId = tripId
        self.userId = userId
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        body    <- map["body"]
        location    <- map["position"]
        createdAt    <- map["createdAt"]
        updatedAt    <- map["updatedAt"]
        tripId    <- map["tripId"]
        userId    <- map["UserId"]
    }
    
    
}

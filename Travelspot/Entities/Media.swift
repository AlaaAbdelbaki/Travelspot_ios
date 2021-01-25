//
//  Media.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 1/9/21.
//

import Foundation
import ObjectMapper

class Media : Mappable{
    
    var id:Int?
    var path:String?
    var createdAt:Date?
    var updatedAt:Date?
    var postId:Int?
    
    required init?(map: Map) {
        
    }
    
    init(id:Int,path:String,createdAt:Date,updatedAt:Date,postId:Int){
        self.id = id
        self.path = path
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.postId = postId
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        path <- map["path"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        postId <- map["postId"]
        
    }
    
    
}

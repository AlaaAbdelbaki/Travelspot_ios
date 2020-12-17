//
//  Trip.swift
//  Travelspot
//
//  Created by Alaa Abdelbaki on 12/9/20.
//

import Foundation
import ObjectMapper

class Trip : Mappable {
    
    var id:Int?
    var title:String?
    var startDate:Date?
    var endDate:Date?
    var location:String?
    var createdAt:Date?
    var updatedAt:Date?
    var userId:Int?
    
    required init?(map: Map) {

        }
    
    init(title:String,startDate:Date,endDate:Date,location:String,userId:Int){
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.userId = userId
    }
    
    func mapping(map: Map) {
        id    <- map["id"]
        title    <- map["title"]
        startDate    <- map["start"]
        endDate    <- map["end"]
        location    <- map["locaitons"]
        createdAt    <- map["createdAt"]
        updatedAt <- map ["updatedAt"]
        userId    <- map["UserId"]
    }
}

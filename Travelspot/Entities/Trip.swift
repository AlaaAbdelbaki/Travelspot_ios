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
    var startDate:Double?
    var endDate:Double?
    var location:String?
    var createdAt:Date?
    var updatedAt:Date?
    var userId:Int?
    
    required init?(map: Map) {

        }
    
    init(title:String,startDate:Double,endDate:Double,location:String,userId:Int){
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
        location    <- map["locations"]
        createdAt    <- map["createdAt"]
        updatedAt <- map ["updatedAt"]
        userId    <- map["UserId"]
    }
}

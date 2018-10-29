//
//  MovieResponse.swift
//  TestMovie
//
//  Created by Tiago on 28/10/2018.
//  Copyright © 2018 Tauã. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

class MovieResponse: Mappable {
    
    var results: [ItemMovie]?
  
    required init?(map: Map){
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        results <- map["results"]

    }

  class ItemMovie: Mappable {
    
    var poster_path: String?
    var backdrop_path: String?
    var original_title: String?
    var overview:String?
    var release_date: String?
    var popularity: Double?
    var vote_count: Int?
    
    required init?(map: Map){
    }
    
    init() {
    }
    
    func mapping(map: Map) {
      poster_path <- map["poster_path"]
      backdrop_path <- map["backdrop_path"]
      original_title <- map["original_title"]
      overview <- map["overview"]
      release_date <- map["release_date"]
      popularity <- map["popularity"]
      vote_count <- map["vote_count"]
     }
    }
    
}


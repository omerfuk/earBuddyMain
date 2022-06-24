//
//  Music.swift
//  earBuddyMain
//
//  Created by Ömer Faruk Kılıçaslan on 24.06.2022.
//

import Foundation

struct Music : Hashable {
    var name : String
    var type : String
    var info : String
    var image : String
    var isFavorite: Bool
    
    init(name: String, type: String, info: String, image: String , isFavorite: Bool) {
        self.name = name
        self.type = type
        self.info = info
        self.image = image
        self.isFavorite = isFavorite
    }
    
    init(){
        self.init(name: "", type: "", info: "", image: "", isFavorite: false)
    }
}

//commitlerim sikerim

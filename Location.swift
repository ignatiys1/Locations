//
//  Location.swift
//  Locations
//
//  Created by Ignat Urbanovich on 7.01.22.
//

import Foundation
import UIKit

class Location {
    
    var name: String
    var imgName: String?
    var image: UIImageView?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, imgName: String?) {
        self.name = name
        self.imgName = imgName
    }
    
    init(name: String, img: UIImageView?) {
        self.name = name
        self.image = img
    }
}

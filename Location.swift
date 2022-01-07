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
    var button: UIButton?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, imgName: String?) {
        self.name = name
        self.imgName = imgName
    }
}

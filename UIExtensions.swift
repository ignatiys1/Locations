//
//  UIExtensions.swift
//  Locations
//
//  Created by Ignat Urbanovich on 3.01.22.
//

import Foundation
import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, textAlignment: NSTextAlignment) {
        self.init()
        
        self.text = text
        //self.textColor = .black
        self.textColor = UIColor(red: 0.129, green: 0.126, blue: 0.125, alpha: 1)
        self.font = font
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = false
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.backgroundColor = .red
    }
}

extension UIFont {
    
    static var avenirNextDemiBold20: UIFont {
        return UIFont.init(name: "Avenir Next Demi Bold", size: 20)!
    }
    
    static var avenirNextDemiBold14: UIFont {
        UIFont(name: "Avenir Next Demi Bold", size: 14)!
    }
    
    static var avenirNext20: UIFont {
        UIFont(name: "Avenir Next", size: 20)!
    }
    
    static var avenirNext14: UIFont {
        UIFont(name: "Avenir Next", size: 14)!
    }
    
    static var avenirNext30: UIFont {
        UIFont(name: "Avenir Next", size: 30)!
    }
    

}

extension UIImageView {

    convenience init(image: UIImage, widthCoef: CGFloat) {
        self.init(image: image)
        
        //self.addGestureRecognizer(tap)
        self.frame = CGRect(x: 0, y: 0, width: 203*widthCoef, height: 203*widthCoef)
        self.backgroundColor = .none
        
        
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = 23*widthCoef
        self.clipsToBounds = true
       
    }
    
}

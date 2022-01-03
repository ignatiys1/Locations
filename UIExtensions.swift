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
    
    convenience init(parent: UIView, view: UIView, image: UIImage, index: Int, widthCoef: CGFloat, heightCoef: CGFloat) {
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 203*widthCoef, height: 203*heightCoef)
        self.backgroundColor = .red
        
        let layer0 = CALayer()
        layer0.contents = image
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.5, b: 0, c: 0, d: 1, tx: -0.25, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        self.layer.addSublayer(layer0)
        
        self.layer.cornerRadius = 23
        
        var horizontalPosition: CGFloat = 20*widthCoef
        switch ((index+1)%3) {
        case 0: horizontalPosition += (203*widthCoef+20*widthCoef)*2
        case 2: horizontalPosition += (203*widthCoef+20*widthCoef)*1
        case 1: horizontalPosition += (203*widthCoef+20*widthCoef)*1
        default: horizontalPosition += 0
        }
        
        var verticalPosition: CGFloat = 90*heightCoef
        switch ((index+1)%6) {
        case 0: verticalPosition += 203*widthCoef+20*widthCoef
        case ...3: verticalPosition += 0
        default: verticalPosition += 203*widthCoef+20*widthCoef
        }
        
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
        self.heightAnchor.constraint(equalToConstant: 203*widthCoef).isActive = true
        self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: horizontalPosition).isActive = true
        self.topAnchor.constraint(equalTo: parent.topAnchor, constant: verticalPosition).isActive = true
    }
    
    
}

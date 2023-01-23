//
//  Extension.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/22/23.
//

import UIKit


extension UIColor {
    //Orange : #FC6016
     var  bellOrange : UIColor {
        return UIColor(red: 252.0/255.0, green: 90.0/255.0, blue: 22.0/255.0, alpha: 1.0)
     }
    
    var  bellDarkGray : UIColor {
        return UIColor(red: 133.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    }
    
    var  bellLightGray : UIColor {
        return UIColor(red: 213.0/255.0, green: 213.0/255.0, blue: 213.0/255.0, alpha: 1.0)
    }

}

extension UIStackView {
    /// Removes  subviews
    func removeArrangedSubviews(where callback: (UIView) -> Bool) {
        for subview in self.arrangedSubviews {
            if callback(subview) {
                self.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}

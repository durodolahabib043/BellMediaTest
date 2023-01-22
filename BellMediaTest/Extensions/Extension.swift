//
//  Extension.swift
//  BellMediaTest
//
//  Created by Habib Durodola on 1/22/23.
//

import UIKit


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

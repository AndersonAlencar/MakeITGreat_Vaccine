//
//  TintColor.swift
//  Vaccine
//
//  Created by David Augusto on 01/12/20.
//

import UIKit
extension UIImageView {
    
    func tintColorTo(color: UIColor) {
        if let image = self.image {
            let templateImage = image.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = color
        }
    }
}

//
//  UIFont+Extension.swift
//  RedRetriever
//
//  Created by Ethan Seiz on 12/1/24.
//

import UIKit

extension UIFont {

    var rounded: UIFont {
        guard let desc = self.fontDescriptor.withDesign(.rounded) else { return self }
        return UIFont(descriptor: desc, size: self.pointSize)
    }

}

//
//  FWFPaddedTextField.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import Foundation
import UIKit

@IBDesignable
class FWFPaddedTextField: UITextField {
    
    @IBInspectable var paddingX: CGFloat = 0
    @IBInspectable var leftPadding: CGFloat = 0
    @IBInspectable var rightPadding: CGFloat = 0
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        return rect.offsetBy(dx: paddingX, dy: 0.0)
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        let padding = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: rightPadding)
        return bounds.inset(by: padding)
    }
}

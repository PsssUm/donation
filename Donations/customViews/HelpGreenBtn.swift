//
//  CustomButton.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit


@IBDesignable public class HelpGreenBtn: UIButton {
    private var shadowLayer: CAShapeLayer!
    private var cornerRadius: CGFloat = 25.0
    private var fillColor: UIColor = .blue // the color applied to the shadowLayer, rather than the view's backgroundColor
    
    
    @IBInspectable var borderColor: UIColor = UIColor.blue {
        didSet {
            layer.borderColor = borderColor.cgColor}
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = ColorHelper().hexStringToUIColor(hex: "#4BB34B")
        layer.cornerRadius = 10

    }
    
    override public var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                //backgroundColor = ColorHelper().hexStringToUIColor(hex: "#88B7EC")
                
                alpha = 0.8
            case false:
                backgroundColor = ColorHelper().hexStringToUIColor(hex: "#4BB34B")
                alpha = 1.0
               
            }
        }
    }
    
}

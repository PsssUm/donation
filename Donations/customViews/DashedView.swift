//
//  DashedView.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class DashedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
     }
   
    var dashBorder: CAShapeLayer?
       
       override func layoutSubviews() {
           super.layoutSubviews()
           dashBorder?.removeFromSuperlayer()
           let dashBorder = CAShapeLayer()
           dashBorder.lineWidth = 1
           dashBorder.strokeColor = ColorHelper().hexStringToUIColor(hex: "3F8AE0").cgColor
           dashBorder.lineDashPattern = [4, 2] as [NSNumber]
           dashBorder.frame = bounds
           dashBorder.fillColor = nil
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
           
           layer.addSublayer(dashBorder)
           self.dashBorder = dashBorder
       }
}

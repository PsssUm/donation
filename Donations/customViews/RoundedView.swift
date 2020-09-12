//
//  RoundedView.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class RoundedView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupView()
     }
    func setupView(){
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.33
        self.layer.borderColor = ColorHelper().hexStringToUIColor(hex: "000000", alpha: 0.08).cgColor
    }
}

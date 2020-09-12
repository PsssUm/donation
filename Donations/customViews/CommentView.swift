//
//  CommentView.swift
//  Donations
//
//  Created by spbiphones on 12.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class CommentView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       setupView()
     }
    func setupView(){
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 1
        self.backgroundColor = ColorHelper().hexStringToUIColor(hex: "F2F3F5")
        self.layer.borderColor = ColorHelper().hexStringToUIColor(hex: "E1E3E6").cgColor
    }
}

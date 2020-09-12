//
//  ViewController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var actionBar = StandartActionBar()
    var didSetupConstraints = false
    override func viewDidLoad() {
        super.viewDidLoad()
        actionBar.title.text = "Пожертвования"
        view.addSubview(actionBar)
        updateViewConstraints()
        // Do any additional setup after loading the view.
    }
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            actionBar.snp.makeConstraints { make in
                make.top.equalTo(self.view.safeArea.top)
                make.left.equalTo(self.view.safeArea.left)
                make.right.equalTo(self.view.safeArea.right)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }


}


//
//  BaseViewController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    var actionBar = StandartActionBar()
      var didSetupConstraints = false
      override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(actionBar)
        updateViewConstraints()
      }
        
   
      func showBackBtn(){
          actionBar.backBtn.isHidden = false
          actionBar.onBackClicked(onBack: {
              self.navigationController?.popViewController(animated: true)
          })
      }
    override func updateViewConstraints() {
          if (!didSetupConstraints) {
              actionBar.snp.makeConstraints { make in
                  make.top.equalTo(self.view.safeArea.top)
                  make.left.equalTo(self.view.safeArea.left)
                  make.right.equalTo(self.view.safeArea.right)
                  make.height.equalTo(56)
              }
              didSetupConstraints = true
          }
          super.updateViewConstraints()
      }
    func setIntercations(view : UIView, recognizer : UITapGestureRecognizer){
           view.isUserInteractionEnabled = true
           view.addGestureRecognizer(recognizer)
       }
   
}

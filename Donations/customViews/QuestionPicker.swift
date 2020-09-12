//
//  QuestionPicker.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class QuestionPicker: UIView {
    
    var onPick : (() -> Void)?
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()
    let title: UILabel = {
          let label = UILabel()
             label.numberOfLines = 1
             label.text = ""
             label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
             label.textColor = ColorHelper().hexStringToUIColor(hex:"#6D7885", alpha : 1)
           return label
    }()
    let text: UILabel = {
          let label = UILabel()
             label.numberOfLines = 1
             label.text = ""
             label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
            label.textColor = ColorHelper().hexStringToUIColor(hex:"#000000", alpha : 1)
           return label
    }()
    let textBG: UIView = {
           let textBG = UIView()
            
             textBG.layer.cornerRadius = 10
             textBG.layer.borderWidth = 0.5
             textBG.backgroundColor = ColorHelper().hexStringToUIColor(hex: "#F2F3F5")
             textBG.layer.borderColor = ColorHelper().hexStringToUIColor(hex: "000000", alpha: 0.12).cgColor

           return textBG
    }()
    let arrowIcon: UIImageView = {
        let pickture = UIImageView()
        pickture.image = UIImage(named : "drop")
        return pickture
    }()
    func onPick(onPick : (() -> Void)?){
        self.onPick = onPick
    }
    @objc func didPicked(tapGestureRecognizer: UITapGestureRecognizer) {
        if (onPick != nil){
            onPick!()
        }
    }
    override init(frame: CGRect) {
           super.init(frame: frame)
           addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(background)
        background.addSubview(title)
        background.addSubview(textBG)
        textBG.addSubview(text)
        textBG.addSubview(arrowIcon)
        updateConstraints()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didPicked(tapGestureRecognizer:)))
        textBG.isUserInteractionEnabled = true
        textBG.addGestureRecognizer(tapGestureRecognizer)
        
    }
  

   
    
    override func updateConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(self.safeArea.top)
            make.left.equalTo(self.safeArea.left)
            make.right.equalTo(self.safeArea.right)
            make.height.equalTo(96)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top).offset(14)
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
        }
        textBG.snp.makeConstraints { make in
            make.top.equalTo(title.safeArea.bottom).offset(8)
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
            make.height.equalTo(44)
        }
        text.snp.makeConstraints { make in
            make.top.equalTo(textBG.safeArea.top).offset(12)
            make.left.equalTo(textBG.safeArea.left).offset(12)
            make.right.equalTo(arrowIcon.safeArea.left).offset(-12)
        }
        arrowIcon.snp.makeConstraints { make in
            make.top.equalTo(textBG.safeArea.top).offset(10)
            make.right.equalTo(textBG.safeArea.right).inset(10)
            make.height.width.equalTo(24)
        }
        super.updateConstraints()
    }
   
}

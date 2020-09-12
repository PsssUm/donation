//
//  StandartActionBar.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class StandartActionBar: UIView {
    var onBack : (() -> Void)?
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()
    let backImage: UIImageView = {
        let back = UIImageView()
        back.image = UIImage(named : "back")
        return back
    }()
    let backBtn: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()
    let line: UIView = {
        let bg = UIView()
        bg.backgroundColor = ColorHelper().hexStringToUIColor(hex: "#D7D8D9")
        return bg
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        label.textColor = UIColor(named: "navigationTitle")
        return label
    }()
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
        background.addSubview(line)
        background.addSubview(backBtn)
        backBtn.addSubview(backImage)
        backBtn.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didBackClicked(tapGestureRecognizer:)))
        backBtn.isUserInteractionEnabled = true
        backBtn.addGestureRecognizer(tapGestureRecognizer)
        
        updateConstraints()
        
    }
    func onBackClicked(onBack : (() -> Void)?){
        self.onBack = onBack
    }
    func hideLine(){
        self.line.isHidden = true
    }
    @objc func didBackClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        if (onBack != nil){
            onBack!()
        }
    }

    override func updateConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(self.safeArea.top)
            make.left.equalTo(self.safeArea.left)
            make.right.equalTo(self.safeArea.right)
            make.height.equalTo(56)
        }
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top).offset(4)
            make.left.equalTo(background.safeArea.left)
            make.bottom.equalTo(background.safeArea.bottom).inset(4)
            make.width.equalTo(44)
        }
        backImage.snp.makeConstraints { make in
            make.top.equalTo(backBtn.safeArea.top).offset(8)
            make.left.equalTo(backBtn.safeArea.left).offset(8)
            make.height.equalTo(28)
            make.width.equalTo(20)
        }
        line.snp.makeConstraints { make in
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
            make.bottom.equalTo(background.safeArea.bottom).inset(3)
            make.height.equalTo(0.33)
        }
        title.snp.makeConstraints { make in
            make.centerX.equalTo(background.safeArea.centerX)
            make.bottom.equalTo(line.safeArea.bottom).inset(13.5)
        }
        super.updateConstraints()
    }
}

//
//  OptionsRadio.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//
import Foundation
import UIKit
import SnapKit
class OptionsRadio: UIView {
    var onChanged : ((_ isDate : Bool) -> Void)?
    var isInDate = true
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()
    let summView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        return bg
    }()
    let dateView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .clear
        return bg
    }()
    let title: UILabel = {
          let label = UILabel()
             label.numberOfLines = 1
             label.text = "Сбор завершится"
             label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
             label.textColor = ColorHelper().hexStringToUIColor(hex:"#6D7885", alpha : 1)
           return label
    }()
    let sumText: UILabel = {
          let label = UILabel()
             label.numberOfLines = 1
             label.text = "Когда соберём сумму"
             label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
           return label
    }()
    let dateText: UILabel = {
          let label = UILabel()
             label.numberOfLines = 1
             label.text = "В определённую дату"
             label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
           return label
    }()
    let summIcon: UIImageView = {
        let pickture = UIImageView()
        pickture.image = UIImage(named : "state_off")
        return pickture
    }()
    let dateIcon: UIImageView = {
        let pickture = UIImageView()
        pickture.image = UIImage(named : "state_on")
        return pickture
    }()
    override init(frame: CGRect) {
           super.init(frame: frame)
           addViews()
    }
    func onChanged(onChanged : ((_ isDate : Bool) -> Void)?){
        self.onChanged = onChanged
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        self.addSubview(background)
        background.addSubview(title)
        background.addSubview(summIcon)
        background.addSubview(dateIcon)
        background.addSubview(sumText)
        background.addSubview(dateText)
        background.addSubview(summView)
        background.addSubview(dateView)
        updateConstraints()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(summPicked(tapGestureRecognizer:)))
        summView.isUserInteractionEnabled = true
        summView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(datePicked(tapGestureRecognizer:)))
        dateView.isUserInteractionEnabled = true
        dateView.addGestureRecognizer(tapGestureRecognizer2)
        
    }
  
    @objc func summPicked(tapGestureRecognizer: UITapGestureRecognizer) {
        isInDate = false
        summIcon.image = UIImage(named: "state_on")
        dateIcon.image = UIImage(named: "state_off")
        if (onChanged != nil){
            onChanged!(isInDate)
        }
    }
    @objc func datePicked(tapGestureRecognizer: UITapGestureRecognizer) {
        isInDate = true
        summIcon.image = UIImage(named: "state_off")
        dateIcon.image = UIImage(named: "state_on")
        if (onChanged != nil){
            onChanged!(isInDate)
        }
    }
   
    override func updateConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(self.safeArea.top)
            make.left.equalTo(self.safeArea.left)
            make.right.equalTo(self.safeArea.right)
            make.height.equalTo(140)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top).offset(14)
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
        }
        summIcon.snp.makeConstraints { make in
            make.top.equalTo(title.safeArea.bottom).offset(8)
            make.left.equalTo(background.safeArea.left)
            make.height.equalTo(44)
            make.width.equalTo(48)
        }
        dateIcon.snp.makeConstraints { make in
            make.top.equalTo(summIcon.safeArea.bottom)
            make.left.equalTo(background.safeArea.left)
            make.height.equalTo(44)
            make.width.equalTo(48)
        }
        sumText.snp.makeConstraints { make in
            make.top.equalTo(summIcon.safeArea.top).offset(11)
            make.left.equalTo(summIcon.safeArea.right)
        }
        dateText.snp.makeConstraints { make in
            make.top.equalTo(dateIcon.safeArea.top).offset(11)
            make.left.equalTo(summIcon.safeArea.right)
        }
        summView.snp.makeConstraints { make in
            make.top.equalTo(title.safeArea.bottom).offset(8)
            make.left.equalTo(background.safeArea.left)
            make.right.equalTo(background.safeArea.right)
            make.height.equalTo(44)
        }
        dateView.snp.makeConstraints { make in
            make.top.equalTo(summView.safeArea.bottom)
            make.left.equalTo(background.safeArea.left)
            make.right.equalTo(background.safeArea.right)
            make.height.equalTo(44)
        }
        
        super.updateConstraints()
    }
   
}

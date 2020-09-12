//
//  QuestionInput.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
class QuestionInput: UIView, UITextViewDelegate {
    var inputHeight = 44
    var answerPlaceHolder = ""
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
    let answer: UITextView = {
           let answer = UITextView()
             answer.text = ""
             answer.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
             answer.layer.cornerRadius = 10
             answer.layer.borderWidth = 0.5
             answer.backgroundColor = ColorHelper().hexStringToUIColor(hex: "#F2F3F5")
             answer.layer.borderColor = ColorHelper().hexStringToUIColor(hex: "000000", alpha: 0.12).cgColor
             answer.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        
            answer.textColor = ColorHelper().hexStringToUIColor(hex: "#818C99")
           return answer
    }()
    override init(frame: CGRect) {
           super.init(frame: frame)
           addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setPlaceHolder(placeholder : String){
        answerPlaceHolder = placeholder
        textViewDidEndEditing(answer)
    }
    func addViews(){
        self.addSubview(background)
        background.addSubview(title)
        background.addSubview(answer)
        answer.delegate = self
        answer.text = self.answerPlaceHolder
        updateConstraints()
        
    }
  
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == ColorHelper().hexStringToUIColor(hex: "#818C99") {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text.isEmpty {
            textView.text = answerPlaceHolder
            textView.textColor = ColorHelper().hexStringToUIColor(hex: "#818C99")
        }
    }
   
    override func updateConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(self.safeArea.top)
            make.left.equalTo(self.safeArea.left)
            make.right.equalTo(self.safeArea.right)
            make.height.equalTo(inputHeight + 52)
        }
        title.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top).offset(14)
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
        }
        answer.snp.makeConstraints { make in
            make.top.equalTo(title.safeArea.bottom).offset(8)
            make.left.equalTo(background.safeArea.left).offset(12)
            make.right.equalTo(background.safeArea.right).inset(12)
            make.height.equalTo(inputHeight)
        }
        super.updateConstraints()
    }
    func updateHeightConstr(){
        answer.snp.updateConstraints { make in
            make.height.equalTo(inputHeight)
        }
    }
}

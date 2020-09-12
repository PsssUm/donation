//
//  ImagePickerView.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class ImagePickerView: UIView {
    var onPickImage : (() -> Void)?
    var onDismiss : (() -> Void)?
    let background: UIView = {
        let bg = UIView()
        bg.backgroundColor = .white
        return bg
    }()
    let dashedView: DashedView = {
        let bg = DashedView()
        bg.backgroundColor = .white
        return bg
    }()
    let imageView: UIView = {
        let bg = UIView()
        bg.layer.cornerRadius = 10
        bg.backgroundColor = .white
        return bg
    }()
    let imageViewPicked: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        return image
    }()
    let text: UILabel = {
       let label = UILabel()
          label.numberOfLines = 1
          label.text = "Загрузить обложку"
          label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
          label.textColor = ColorHelper().hexStringToUIColor(hex:"#3F8AE0", alpha : 1)
        return label
    }()
    let picktureIcon: UIImageView = {
        let pickture = UIImageView()
        pickture.image = UIImage(named : "pickture")
        return pickture
    }()
    let dismissIcon: UIImageView = {
        let pickture = UIImageView()
        pickture.image = UIImage(named : "dismiss")
        return pickture
    }()
    override init(frame: CGRect) {
           super.init(frame: frame)
           addViews()
    }
    func onPickImage(onPickImage : (() -> Void)?){
        self.onPickImage = onPickImage
    }
    func onDismiss(onDismiss : (() -> Void)?){
        self.onDismiss = onDismiss
    }
    @objc func didDismissed(tapGestureRecognizer: UITapGestureRecognizer) {
        if (onDismiss != nil){
            onDismiss!()
        }
    }
      
    @objc func didImagePicked(tapGestureRecognizer: UITapGestureRecognizer) {
        if (onPickImage != nil){
            onPickImage!()
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addViews(){
        self.addSubview(background)
        background.addSubview(dashedView)
        background.addSubview(imageView)
        imageView.addSubview(imageViewPicked)
        imageView.addSubview(dismissIcon)
        dashedView.addSubview(text)
        dashedView.addSubview(picktureIcon)
        updateConstraints()
        setListeners()
        toogleImage(isHideImageView: true)
    }
    func setListeners(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didImagePicked(tapGestureRecognizer:)))
        dashedView.isUserInteractionEnabled = true
        dashedView.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(didDismissed(tapGestureRecognizer:)))
        dismissIcon.isUserInteractionEnabled = true
        dismissIcon.addGestureRecognizer(tapGestureRecognizer2)
    }
    func toogleImage(isHideImageView : Bool){
        dashedView.isHidden = !isHideImageView
        imageView.isHidden = isHideImageView
    }
    override func updateConstraints() {
        background.snp.makeConstraints { make in
            make.top.equalTo(self.safeArea.top)
            make.left.equalTo(self.safeArea.left).offset(12)
            make.right.equalTo(self.safeArea.right).inset(12)
            make.height.equalTo(140)
        }
        dashedView.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top)
            make.left.equalTo(background.safeArea.left)
            make.right.equalTo(background.safeArea.right)
            make.bottom.equalTo(background.safeArea.bottom)
        }
        text.snp.makeConstraints { make in
            make.centerX.equalTo(dashedView.safeArea.centerX).offset(18)
            make.centerY.equalTo(dashedView.safeArea.centerY)
        }
        picktureIcon.snp.makeConstraints { make in
            make.right.equalTo(text.safeArea.left).offset(-8)
            make.centerY.equalTo(dashedView.safeArea.centerY)
            make.height.width.equalTo(28)
        }
        imageView.snp.makeConstraints { make in
            make.top.equalTo(background.safeArea.top)
            make.left.equalTo(background.safeArea.left)
            make.right.equalTo(background.safeArea.right)
            make.bottom.equalTo(background.safeArea.bottom)
        }
        imageViewPicked.snp.makeConstraints { make in
            make.top.equalTo(imageView.safeArea.top)
            make.left.equalTo(imageView.safeArea.left)
            make.right.equalTo(imageView.safeArea.right)
            make.bottom.equalTo(imageView.safeArea.bottom)
        }
        dismissIcon.snp.makeConstraints { make in
            make.top.equalTo(imageView.safeArea.top).offset(8)
            make.right.equalTo(imageView.safeArea.right).inset(8)
        }
        super.updateConstraints()
    }
}

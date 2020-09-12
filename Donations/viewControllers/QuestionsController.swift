//
//  QuestionsController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class QuestionsController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var actionBarTitle = ""
    var isTargetDonations = true
    var didSetConstraints = false
    let scrollView  = UIScrollView()
    let contentView = UIView()
    let imagePickerView = ImagePickerView()
    var imagePicker : UIImagePickerController!
    var pickedImage : UIImage!
    let nameQuestion = QuestionInput()
    let summQuestion = QuestionInput()
    let targetQuestion = QuestionInput()
    let descrQuestion = QuestionInput()
    let payPicker = QuestionPicker()
    let authorPicker = QuestionPicker()
    let nextBtn = CustomButton()
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
        actionBar.title.text = actionBarTitle
        showBackBtn()
        actionBar.hideLine()
        updateViewConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setUpView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imagePickerView)
        contentView.addSubview(nameQuestion)
        contentView.addSubview(summQuestion)
        contentView.addSubview(targetQuestion)
        contentView.addSubview(descrQuestion)
        contentView.addSubview(payPicker)
        contentView.addSubview(authorPicker)
        contentView.addSubview(nextBtn)
        scrollView.keyboardDismissMode = .onDrag
        setListeners()
        setUpQuestions()
    }
    func setListeners(){
        imagePicker = ImagePickerHelper.getImagePicker()
        imagePicker.delegate = self
        imagePickerView.onPickImage(onPickImage : {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        })
        imagePickerView.onDismiss(onDismiss : {
            self.imagePickerView.toogleImage(isHideImageView: true)
            self.pickedImage = nil
        })
        nextBtn.setTitle("Далее", for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        nextBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        payPicker.onPick(onPick : {
            self.showBottomPayPicker()
        })
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[.editedImage] as? UIImage {
            self.pickedImage = pickedImage
            self.imagePickerView.imageViewPicked.image = pickedImage
            self.imagePickerView.toogleImage(isHideImageView: false)
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    func setUpQuestions(){
        nameQuestion.title.text = "Название сбора"
        nameQuestion.setPlaceHolder(placeholder : "Название сбора")
        
        summQuestion.title.text = "Сумма, ₽"
        summQuestion.setPlaceHolder(placeholder : "Сколько нужно собрать?")
        
        targetQuestion.title.text = "Цель"
        targetQuestion.setPlaceHolder(placeholder : "Например, лечение человека")
        summQuestion.answer.keyboardType = .numberPad
        descrQuestion.title.text = "Описание"
        descrQuestion.setPlaceHolder(placeholder : "На что пойдут деньги и как они кому-то помогут?")
        descrQuestion.inputHeight = 64
        descrQuestion.updateHeightConstr()
        
        payPicker.title.text = "Куда получать деньги"
        payPicker.text.text = "Счёт VK Pay · 1234"
        
        authorPicker.title.text = "Автор"
        authorPicker.text.text = "Матвей Правосудов"
        
    }
    @objc func buttonClicked(){
        self.view.endEditing(true)
        if (summQuestion.answer.text != "Сколько нужно собрать?" && summQuestion.answer.text != nil && pickedImage != nil && nameQuestion.answer.text != "Название сбора" && targetQuestion.answer.text != "Например, лечение человека" && descrQuestion.answer.text != "На что пойдут деньги и как они кому-то помогут?"){
            let postModel = createModel()
            if (isTargetDonations){
                let questionsController = self.storyboard!.instantiateViewController(withIdentifier: "OptionsController") as! OptionsController
                questionsController.postModel = postModel
                questionsController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(questionsController, animated: true)
            } else {
                let postEditController = self.storyboard!.instantiateViewController(withIdentifier: "PostEditController") as! PostEditController
                postEditController.postModel = postModel
                postEditController.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(postEditController, animated: true)
            }
        } else {
            view.makeToast("Заполните недостающие поля")
        }
    }
    func createModel() -> PostModel{
        let postModel = PostModel()
        postModel.image = pickedImage
        postModel.title = nameQuestion.answer.text
        postModel.summ = Int(summQuestion.answer.text) ?? 10000
        postModel.target = targetQuestion.answer.text
        postModel.description = descrQuestion.answer.text
        postModel.payment = payPicker.text.text ?? ""
        postModel.author = authorPicker.text.text ?? ""
        return postModel
    }
    
    func showBottomPayPicker(){
        let payPickerAlert = UIAlertController(title: "Куда получать деньги", message: "Выберите нужный счет", preferredStyle: UIAlertController.Style.actionSheet)
        let vk = "Счёт VK Pay · 1234"
        let yandex = "Я.Деньги 400821334"
        let qiwiText = "Qiwi +77776633"
        let vkPay = UIAlertAction(title: vk, style: .default) { (action: UIAlertAction) in
            self.payPicker.text.text = vk
        }
        let yandexMoney = UIAlertAction(title: yandex, style: .default) { (action: UIAlertAction) in
            self.payPicker.text.text = yandex
        }
        let qiwi = UIAlertAction(title: qiwiText, style: .default) { (action: UIAlertAction) in
            self.payPicker.text.text = qiwiText
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        payPickerAlert.addAction(vkPay)
        payPickerAlert.addAction(yandexMoney)
        payPickerAlert.addAction(qiwi)
        payPickerAlert.addAction(cancelAction)
        self.present(payPickerAlert, animated: true, completion: nil)
    }
    
    
    override func updateViewConstraints() {
        if (!didSetConstraints) {
            scrollView.snp.makeConstraints { make in
                make.top.equalTo(actionBar.safeArea.bottom)
                make.left.equalTo(self.view.safeArea.left)
                make.bottom.equalTo(self.view.safeArea.bottom)
                make.right.equalTo(self.view.safeArea.right)
            }
            imagePickerView.snp.makeConstraints { make in
                make.top.equalTo(contentView.safeArea.top).offset(1)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(140)
            }
            nameQuestion.snp.makeConstraints { make in
                make.top.equalTo(imagePickerView.safeArea.bottom).offset(1)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(96)
            }
            summQuestion.snp.makeConstraints { make in
                make.top.equalTo(nameQuestion.safeArea.bottom)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(96)
            }
            targetQuestion.snp.makeConstraints { make in
                make.top.equalTo(summQuestion.safeArea.bottom)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(96)
            }
            descrQuestion.snp.makeConstraints { make in
                make.top.equalTo(targetQuestion.safeArea.bottom)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(116)
            }
            payPicker.snp.makeConstraints { make in
                make.top.equalTo(descrQuestion.safeArea.bottom)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(96)
            }
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView).inset(UIEdgeInsets.zero)
                make.width.equalTo(scrollView)
                make.height.equalTo(806)
            }
            authorPicker.snp.makeConstraints { make in
                make.top.equalTo(payPicker.safeArea.bottom)
                make.left.equalTo(contentView.safeArea.left)
                make.right.equalTo(contentView.safeArea.right)
                make.height.equalTo(96)
            }
            nextBtn.snp.makeConstraints { make in
                make.top.equalTo(authorPicker.safeArea.bottom).offset(12)
                make.left.equalTo(contentView.safeArea.left).offset(12)
                make.right.equalTo(contentView.safeArea.right).inset(12)
                make.height.equalTo(44)
            }

            didSetConstraints = true
        }
        super.updateViewConstraints()
    }
    @objc func keyboardWillShow(notification:NSNotification){
        if UIApplication.shared.applicationState != .active { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardHeight: CGFloat
        if #available(iOS 11.0, *) {
            keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
        } else {
            keyboardHeight = keyboardFrame.cgRectValue.height
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
            if (self.descrQuestion.answer.text == "" || self.descrQuestion.answer.text == nil || self.targetQuestion.answer.text == ""){
               self.scrollView.contentInset.bottom = keyboardHeight
               let bottomOffset = CGPoint(x: 0, y: keyboardHeight)
               self.scrollView.setContentOffset(bottomOffset, animated: true)
           }
        }
        
        

    }

    @objc func keyboardWillHide(notification:NSNotification){
        scrollView.contentInset.bottom = 0
    }
  
}

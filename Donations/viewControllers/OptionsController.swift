//
//  OptionsController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class OptionsController: BaseViewController {
    var didSetConstraints = false
    var postModel : PostModel!
    var myDatePicker: UIDatePicker!
    let authorPicker = QuestionPicker()
    let optionsRadio = OptionsRadio()
    let datePicker = QuestionPicker()
    var selectedDate = 0.0
    var isDate = true
    let createBtn = CustomButton()
    override func viewDidLoad() {
        setUpView()
        super.viewDidLoad()
        actionBar.title.text = "Дополнительно"
        showBackBtn()
        
        updateViewConstraints()
    }
    func setUpView(){
        view.addSubview(authorPicker)
        view.addSubview(optionsRadio)
        view.addSubview(datePicker)
        view.addSubview(createBtn)
        authorPicker.title.text = "Автор"
        authorPicker.text.text = "Матвей Правосудов"
        
        datePicker.title.text = "Дата окончания"
        datePicker.text.text = "Выберите дату"
        datePicker.text.textColor = ColorHelper().hexStringToUIColor(hex: "#818C99")
        myDatePicker = UIDatePicker()
        myDatePicker.timeZone = NSTimeZone.local
        selectedDate = Date().timeIntervalSince1970
        datePicker.onPick(onPick : {
            self.createDatePickerAlert()
        })
        createBtn.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        createBtn.setTitle("Далее", for: .normal)
        createBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        optionsRadio.onChanged(onChanged : { isDate in
            self.isDate = isDate
            if isDate {
                if (self.datePicker.text.text != "Выберите дату"){
                     self.enableBtn()
                } else {
                    self.disableBtn()
                }
            } else {
                self.postModel.date = 0.0
                self.enableBtn()
            }
        })
        disableBtn()
    }
    @objc func buttonClicked(){
        postModel.isTargetDonation = true
        let postEditController = self.storyboard!.instantiateViewController(withIdentifier: "PostEditController") as! PostEditController
        postEditController.postModel = postModel
        postEditController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(postEditController, animated: true)
    }
  
    func enableBtn(){
        self.createBtn.alpha = 1.0
        self.createBtn.isEnabled = true
    }
    func disableBtn(){
        self.createBtn.alpha = 0.4
        self.createBtn.isEnabled = false
    }
   func createDatePickerAlert(){
       myDatePicker.frame = CGRect(x: 0, y: 15, width: 270, height: 200)
       let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertController.Style.alert)
       alertController.view.addSubview(myDatePicker)
       let selectAction = UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { _ in
           self.selectedDate = self.myDatePicker.date.timeIntervalSince1970
           self.datePicker.text.text = DateHelper.transformTimeToHumanReadable(interval : self.selectedDate)
           self.datePicker.text.textColor = .black
           self.postModel.date = self.myDatePicker.date.timeIntervalSince1970
           self.enableBtn()
       })
       let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel, handler: nil)
       alertController.addAction(selectAction)
       alertController.addAction(cancelAction)
       present(alertController, animated: true, completion:{})
   }
    override func updateViewConstraints() {
        if (!didSetConstraints) {
            authorPicker.snp.makeConstraints { make in
                make.top.equalTo(actionBar.safeArea.bottom)
                make.left.equalTo(self.view.safeArea.left)
                make.right.equalTo(self.view.safeArea.right)
                make.height.equalTo(96)
            }
            optionsRadio.snp.makeConstraints { make in
                make.top.equalTo(authorPicker.safeArea.bottom)
                make.left.equalTo(self.view.safeArea.left)
                make.right.equalTo(self.view.safeArea.right)
                make.height.equalTo(140)
            }
            datePicker.snp.makeConstraints { make in
                make.top.equalTo(optionsRadio.safeArea.bottom)
                make.left.equalTo(self.view.safeArea.left)
                make.right.equalTo(self.view.safeArea.right)
                make.height.equalTo(96)
            }
            createBtn.snp.makeConstraints { make in
                make.left.equalTo(self.view.safeArea.left).offset(12)
                make.right.equalTo(self.view.safeArea.right).inset(12)
                make.bottom.equalTo(self.view.safeArea.bottom).inset(12)
                make.height.equalTo(44)
            }
            didSetConstraints = true
        }
        super.updateViewConstraints()
    }
    
   
}

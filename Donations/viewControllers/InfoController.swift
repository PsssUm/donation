//
//  InfoController.swift
//  Donations
//
//  Created by spbiphones on 12.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit

class InfoController: UIViewController {
    var postModel : PostModel!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    var isAnimate = true
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var topProgressWidth: NSLayoutConstraint!
    
    @IBOutlet weak var botProgressWidth: NSLayoutConstraint!
    @IBOutlet weak var botProgressTV: UILabel!
    @IBOutlet weak var botProgressView: UIView!
    @IBOutlet weak var botProgressBG: UIView!
    @IBOutlet weak var progressWhiteTV: UILabel!
    @IBOutlet weak var progressGreenTV: UILabel!
    @IBOutlet weak var progressGrayTV: UILabel!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressBG: UIView!
    @IBOutlet weak var progressDateTV: UILabel!
    @IBOutlet weak var descriptionTV: UILabel!
    @IBOutlet weak var dateTV: UILabel!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var titleTV: UILabel!
    @IBOutlet weak var backIV: UIImageView!
    @IBOutlet weak var finishedTV: UILabel!
    @IBOutlet weak var topRightProgressTV: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImageView()
        titleTV.text = postModel.title
        nameTV.text = postModel.author
        descriptionTV.text = postModel.description
        roundProgress()
        animateProgress(progressTV: botProgressTV, progressBG: botProgressBG, progressView: botProgressView, postModel: postModel)
        animateTopProgress(progressBG: progressBG, progressView: progressView, postModel: postModel)
        setListeners()
        if (!postModel.isTargetDonation){
            progressDateTV.text = "Нужно собрать в сентябре"
            dateTV.text = "Помощь нужна каждый месяц"
        } else {
            var dates = ""
            if postModel.date < 1.0{
                dates = "Собрать до нужной суммы"
                dateTV.text = "Неизвестно, когда закончится сбор"
            } else {
               dates = "Нужно собрать до \(DateHelper.transformTimeToHumanReadable(interval : postModel.date))"
                dateTV.text = "Сбор закончится через \(DateHelper().timeStampToDay(timeStampInSecond: postModel.date)) дн."
            }
            progressDateTV.text = dates
            
        }
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        updateScrollHeight()
    }
    func updateScrollHeight(){
        print("descriptionTV height = \(descriptionTV.frame.size.height)")
        scrollViewHeight.constant = descriptionTV.frame.size.height + CGFloat(420)
        view.layoutIfNeeded()
    }
    @IBAction func helpBTN(_ sender: Any) {
        
    }
    func setUpImageView(){
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.contentMode = .scaleAspectFill
        imageIV.layer.masksToBounds = true
        imageIV.clipsToBounds = true
        imageIV.image = postModel.image
    }
    func roundProgress(){
        progressBG.layer.cornerRadius = 6
        progressView.layer.cornerRadius = 6
        botProgressBG.layer.cornerRadius = 2
        botProgressView.layer.cornerRadius = 2
    }
    func setListeners(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(back(tapGestureRecognizer:)))
        backIV.isUserInteractionEnabled = true
        backIV.addGestureRecognizer(tapGestureRecognizer)
    }
    @objc func back(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        isAnimate = false
        super.viewDidDisappear(animated)
    }
    func animateProgress(progressTV : UILabel, progressBG : UIView, progressView : UIView, postModel : PostModel){
           let allMoney = postModel.summ
           let step = allMoney / (Int.random(in: 50..<100))
           let newProgress = step
           progressTV.fadeTransition(0.4)
           loopAnimation(progressTV: progressTV, step: step, allMoney: allMoney, newProgress: newProgress)
           
    }
    func loopAnimation(progressTV : UILabel, step : Int,allMoney : Int, newProgress : Int){
           var newProg = newProgress + step
           if (newProgress > allMoney){
               newProg = 0
           }
           Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
                  UIView.animate(withDuration: 0.1, animations: {
                        let currentProgress = (CGFloat(newProgress) / CGFloat(allMoney))
                        progressTV.text = "Собрано \(newProgress) ₽ из \(allMoney) ₽"
                        self.botProgressWidth.constant = self.botProgressBG.frame.size.width * CGFloat(currentProgress)
                        self.view.layoutIfNeeded()
                   if self.isAnimate{
                       self.loopAnimation(progressTV: progressTV, step: step, allMoney: allMoney, newProgress: newProg)
                   }
                  })
           }
       }
    
    func animateTopProgress(progressBG : UIView, progressView : UIView, postModel : PostModel){
        let allMoney = postModel.summ
        let step = allMoney / (Int.random(in: 50..<100))
        let newProgress = step
        progressGrayTV.fadeTransition(0.4)
        progressGreenTV.fadeTransition(0.4)
        progressWhiteTV.fadeTransition(0.4)
        toogleProgressTv(isHideWhite: true)
        self.progressGrayTV.text = "\(allMoney) ₽"
        self.topRightProgressTV.text = "\(allMoney) ₽"
        loopTopAnimation(step: step, allMoney: allMoney, newProgress: newProgress)
           
    }
    func loopTopAnimation(step : Int,allMoney : Int, newProgress : Int){
           var newProg = newProgress + step
           if (newProgress > allMoney){
               newProg = 0
           }
        finishedTV.isHidden = true
           Timer.scheduledTimer(withTimeInterval: 0.08, repeats: false) { _ in
                  UIView.animate(withDuration: 0.08, animations: {
                        let currentProgress = (CGFloat(newProgress) / CGFloat(allMoney))
                        self.topProgressWidth.constant = self.progressBG.frame.size.width * CGFloat(currentProgress)
                        self.progressGreenTV.text = "\(newProgress) ₽"
                        self.progressWhiteTV.text = "\(newProgress) ₽"
                        if CGFloat(currentProgress) > 0.25 {
                            self.toogleProgressTv(isHideWhite: false)
                        } else {
                            self.toogleProgressTv(isHideWhite: true)
                        }
                        if CGFloat(currentProgress) > 0.8 {
                            self.progressGrayTV.isHidden = true
                            self.topRightProgressTV.isHidden = false
                        } else {
                            self.progressGrayTV.isHidden = false
                            self.topRightProgressTV.isHidden = true
                        }
                        self.view.layoutIfNeeded()
                        if CGFloat(currentProgress) >= 1.0 {
                            self.progressGrayTV.isHidden = true
                            self.finishedTV.isHidden = false
                            self.progressWhiteTV.isHidden = true
                            self.finishedTV.text = "\(allMoney) ₽ собраны!"
                            self.progressGreenTV.isHidden = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
                              if self.isAnimate{
                                   self.loopTopAnimation(step: step, allMoney: allMoney, newProgress: newProg)
                               }
                            }
                        } else {
                            if self.isAnimate{
                                self.loopTopAnimation(step: step, allMoney: allMoney, newProgress: newProg)
                            }
                        }
                       
                  })
           }
       }
    func toogleProgressTv(isHideWhite : Bool){
        progressGreenTV.isHidden = !isHideWhite
        progressWhiteTV.isHidden = isHideWhite
    }
    
}

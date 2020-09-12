//
//  NewsController.swift
//  Donations
//
//  Created by spbiphones on 12.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//
import Foundation
import UIKit

class NewsController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    let news : [PostModel] = NewsHeap.news.reversed()
    var isAnimate = true
    @IBOutlet weak var newsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        actionBar.title.text = "Новости"
        actionBar.backBtn.isHidden = false
        actionBar.onBackClicked(onBack: {
            let createDonationController = self.storyboard!.instantiateViewController(withIdentifier: "CreateDonationController") as! CreateDonationController
            createDonationController.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(createDonationController, animated: true)
        })
        newsTableView.delegate = self
        newsTableView.dataSource = self
   }
    override func viewDidDisappear(_ animated: Bool) {
        isAnimate = false
        super.viewDidDisappear(animated)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let infoController = self.storyboard!.instantiateViewController(withIdentifier: "InfoController") as! InfoController
        infoController.modalPresentationStyle = .fullScreen
        infoController.postModel = news[indexPath.section]
        self.navigationController?.pushViewController(infoController, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
           
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.imageIV.image = news[indexPath.section].image
        cell.descriptionTV.text = news[indexPath.section].description
        cell.titleTV.text = news[indexPath.section].title
        var dates = ""
        if news[indexPath.section].date < 1.0{
            dates = "До нужной суммы"
        } else {
           dates = "Закончится через \(DateHelper().timeStampToDay(timeStampInSecond: news[indexPath.section].date)) дн."
        }
        if news[indexPath.section].isTargetDonation {
            cell.nameTV.text = "\(news[indexPath.section].author) · \(dates)"
        } else {
            cell.nameTV.text = "\(news[indexPath.section].author) · Помощь нужна каждый месяц"
        }
        animateProgress(progressTV : cell.progressTV, progressBG : cell.progressViewBG, progressView : cell.progressVIew, postModel: news[indexPath.section], cell: cell)
        return cell
    }
    
    func animateProgress(progressTV : UILabel, progressBG : UIView, progressView : UIView, postModel : PostModel, cell : NewsCell){
        let allMoney = postModel.summ
        let step = allMoney / (Int.random(in: 50..<100))
        let newProgress = step
        progressTV.fadeTransition(0.4)
        loopAnimation(progressTV: progressTV, cell: cell, step: step, allMoney: allMoney, newProgress: newProgress)
        
    }
    func loopAnimation(progressTV : UILabel, cell : NewsCell, step : Int,allMoney : Int, newProgress : Int){
        var newProg = newProgress + step
        if (newProgress > allMoney){
            newProg = 0
        }
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
               UIView.animate(withDuration: 0.1, animations: {
                    let currentProgress = (CGFloat(newProgress) / CGFloat(allMoney))
                   progressTV.text = "Собрано \(newProgress) ₽ из \(allMoney) ₽"
                   cell.progressWidth.constant = cell.progressViewBG.frame.size.width * CGFloat(currentProgress)
                   self.view.layoutIfNeeded()
                if self.isAnimate{
                    self.loopAnimation(progressTV: progressTV, cell: cell, step: step, allMoney: allMoney, newProgress: newProg)
                }
               })
        }
    }
    @objc func timerFired(label : UILabel) {
         
    }


}

//
//  PostEditController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit

class PostEditController: BaseViewController {
    
    @IBOutlet weak var textFieldHeight: NSLayoutConstraint!
    var postModel : PostModel!
    @IBOutlet weak var fullnameTV: UILabel!
    @IBOutlet weak var titleTV: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var textET: UITextView!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var sendIV: UIImageView!
    @IBOutlet weak var closeIV: UIImageView!
    @IBOutlet weak var postCard: PostCard!
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var helpBTN: HelpButton!
    override func viewDidLoad() {
       super.viewDidLoad()
       setUpView()
    
   }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("height = \(textET.contentSize.height)")
        var height = textET.contentSize.height
        if (height >= 200){
            height = 200
        }
        textFieldHeight.constant = height
    }
    func setUpView(){
        setUpImageView()
        textET.text = postModel.description
        titleTV.text = postModel.title
        var dates = ""
        if postModel.date < 1.0{
            dates = "До нужной суммы"
        } else {
           dates = "Закончится через \(DateHelper().timeStampToDay(timeStampInSecond: postModel.date)) дн."
        }
        if postModel.isTargetDonation {
            fullnameTV.text = "\(postModel.author) · \(dates)"
        } else {
            fullnameTV.text = "\(postModel.author) · Помощь нужна каждый месяц"
        }
        
        actionBar.isHidden = true
        setListeners()
        progressView.layer.cornerRadius = 2
        helpBTN.alpha = 0.4
    }
    func setUpImageView(){
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.contentMode = .scaleAspectFill
        imageIV.layer.masksToBounds = true
        imageIV.clipsToBounds = true
        imageIV.layer.cornerRadius = 10
        imageIV.image = postModel.image
        
    }
    func setListeners(){
        let closeRec = UITapGestureRecognizer(target: self, action: #selector(close(tapGestureRecognizer:)))
        let postRec = UITapGestureRecognizer(target: self, action: #selector(post(tapGestureRecognizer:)))
        let postCardRec = UITapGestureRecognizer(target: self, action: #selector(postCardClicked(tapGestureRecognizer:)))
        setIntercations(view: closeIV, recognizer: closeRec)
        setIntercations(view: sendIV, recognizer: postRec)
        setIntercations(view: postCard, recognizer: postCardRec)
    }
    @objc func close(tapGestureRecognizer: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func post(tapGestureRecognizer: UITapGestureRecognizer) {
        var news : Array<PostModel> = NewsHeap.news
        news.append(postModel)
        NewsHeap.news = news
        let newsController = self.storyboard!.instantiateViewController(withIdentifier: "NewsController") as! NewsController
        newsController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(newsController, animated: true)
    }

    @objc func postCardClicked(tapGestureRecognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

}

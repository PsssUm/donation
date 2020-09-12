//
//  DonationTypeController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class DonationTypeController: BaseViewController {
   
    @IBOutlet weak var regularDonationView: RoundedView!
    @IBOutlet weak var targetDonationView: RoundedView!
    override func viewDidLoad() {
        super.viewDidLoad()
        actionBar.title.text = "Тип сбора"
        showBackBtn()
        setListeneres()
    }
    func setListeneres(){
        let targetRecognizer = UITapGestureRecognizer(target: self, action: #selector(targetDonationClicked(tapGestureRecognizer:)))
        let regularRecognizer = UITapGestureRecognizer(target: self, action: #selector(regularDonationClicked(tapGestureRecognizer:)))
        setIntercations(view: targetDonationView, recognizer: targetRecognizer)
        setIntercations(view: regularDonationView, recognizer: regularRecognizer)
       
        
    }
    @objc func targetDonationClicked(tapGestureRecognizer: UITapGestureRecognizer) {
          startQuestionsController(isTargetClicked: true)
    }
    @objc func regularDonationClicked(tapGestureRecognizer: UITapGestureRecognizer) {
          startQuestionsController(isTargetClicked: false)
    }
    func startQuestionsController(isTargetClicked : Bool){
        let questionsController = self.storyboard!.instantiateViewController(withIdentifier: "QuestionsController") as! QuestionsController
        questionsController.modalPresentationStyle = .fullScreen
        questionsController.isTargetDonations = isTargetClicked
        if (isTargetClicked){
            questionsController.actionBarTitle = "Целевой сбор"
        } else {
            questionsController.actionBarTitle = "Регулярный сбор"
        }
        self.navigationController?.pushViewController(questionsController, animated: true)
    }
   

    
}

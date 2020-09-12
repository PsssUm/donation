//
//  CreateDonationController.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
class CreateDonationController: BaseViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        actionBar.title.text = "Пожертвования"
       
    }
  
    @IBAction func createDonation(_ sender: Any) {
        let donationTypeController = self.storyboard!.instantiateViewController(withIdentifier: "DonationTypeController") as! DonationTypeController
        donationTypeController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(donationTypeController, animated: true)
    }
    
}

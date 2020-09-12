//
//  NewsCell.swift
//  Donations
//
//  Created by spbiphones on 12.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
import UIKit
class NewsCell: UITableViewCell {
    
    @IBOutlet weak var helpBTN: HelpButton!
    @IBOutlet weak var progressViewBG: UIView!
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var titleTV: UILabel!
    @IBOutlet weak var imageIV: UIImageView!
    @IBOutlet weak var descriptionTV: UILabel!
    @IBOutlet weak var nameIV: UILabel!
    @IBOutlet weak var avatarIV: UIImageView!
    @IBOutlet weak var progressVIew: UIView!
    @IBOutlet weak var progressTV: UILabel!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarIV.layer.cornerRadius = 24
        progressVIew.layer.cornerRadius = 2
        progressViewBG.layer.cornerRadius = 2
        setUpImageView()
    }
    func setUpImageView(){
        
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.contentMode = .scaleAspectFill
        imageIV.layer.masksToBounds = true
        imageIV.clipsToBounds = true
        imageIV.layer.cornerRadius = 10
        
    }
}

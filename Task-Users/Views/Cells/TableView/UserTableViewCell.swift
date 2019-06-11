//
//  UserTableViewCell.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import AlamofireImage

class UserTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: - Variables
    var user: User? {
        didSet{
            guard let user = user else { return }
            
            if let firstName = user.name?.first, let lastName = user.name?.last {
                self.nameLabel.text = firstName + " " + lastName
            }
            
            self.emailLabel.text = user.email
            
            if let userImageUrl = user.picture?.large {
                if let url = URL(string: userImageUrl) {
                    pictureImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, imageTransition: .crossDissolve(0.2)) { (response) in
                    }
                }
            }else {
                pictureImageView.image = UIImage(named: "userDefaultIcon")
            }
            
        }
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureImageView.layer.cornerRadius = pictureImageView.frame.size.height / 2;
        pictureImageView.layer.masksToBounds = true;
    }
}

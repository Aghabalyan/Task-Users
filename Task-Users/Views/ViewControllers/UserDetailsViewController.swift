//
//  UserDetailsViewController.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import RealmSwift

class UserDetailsViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var saveOrRemoveBt: UIButton!
    
    // MARK: - Variables
    var user: User?
    var isUserSaved = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUserDetailView()
        self.navigationItem.largeTitleDisplayMode = .never
        
        let realm = try! Realm()
        if let _ = realm.objects(UserRM.self).filter({$0.userId == self.user?.userId}).first {
            saveOrRemoveBt.setTitle("Remove", for: .normal)
            saveOrRemoveBt.setTitleColor(.red, for: .normal)
            isUserSaved = true
        }else {
            saveOrRemoveBt.setTitle("Save", for: .normal)
            saveOrRemoveBt.setTitleColor(.white, for: .normal)
            isUserSaved = false
        }
    }
    
    // MARK: - Init
    func initUserDetailView() {
        guard let user = user else {return}
        if let userImageUrl = user.picture?.large {
            if let url = URL(string: userImageUrl) {
                imageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, imageTransition: .crossDissolve(0.2)) { (response) in
                }
            }
        }else {
            imageView.image = UIImage(named: "userDefaultIcon")
        }
        
        if let firstName = user.name?.first, let lastName = user.name?.last {
            self.nameLabel.text = firstName + " " + lastName
        }
        emailLabel.text = user.email
        genderLabel.text = user.gender
        phoneLabel.text = user.phone
        
        if let city = user.location?.city, let state = user.location?.state, let postcode = user.location?.postcode {
            locationLabel.text = city + "," + state + "," + postcode
        }else if let city = user.location?.city, let state = user.location?.state {
            locationLabel.text = city + "," + state
        }else if let city = user.location?.city {
            locationLabel.text = city
        }
    }
    
    // MARK: - Actions
    @IBAction func saveOrRemoveAction(_ sender: Any) {
        isUserSaved ? deleteUser() : saveUser()
    }
    
    // MARK: - Realm
    func saveUser() {
        guard let user = user else {return}
        UserManager.shared.saveUser(user: user) { (id) in
            self.user?.id = id
            saveOrRemoveBt.setTitle("Remove", for: .normal)
            saveOrRemoveBt.setTitleColor(.red, for: .normal)
            isUserSaved = true
        }
    }
    
    func deleteUser() {
        let realm = try! Realm()
        if let userToDelete = realm.object(ofType: UserRM.self, forPrimaryKey: user?.id ?? 0) {
            UserManager.shared.remove(user: userToDelete)
            saveOrRemoveBt.setTitle("Save", for: .normal)
            saveOrRemoveBt.setTitleColor(.white, for: .normal)
            isUserSaved = false
        }
    }
}

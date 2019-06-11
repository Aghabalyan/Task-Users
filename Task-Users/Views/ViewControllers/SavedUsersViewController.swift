//
//  SavedUsersViewController.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit
import RealmSwift

class SavedUsersViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    private let userCell = "UserTableViewCell"
    var users: [User] = []
    var usersRM: Results<UserRM>!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        getUsersFromRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsersFromRealm()
    }
    
    // MARK: - Setups
    func setupNavBar() {
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    // MARK: - Registers
    private func registerCell() {
        let nib = UINib(nibName: userCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: userCell)
    }
    
    // MARK: - Realm
    func getUsersFromRealm() {
        users.removeAll()
        let realm = try! Realm()
        usersRM = realm.objects(UserRM.self)
        for userRM in usersRM {
            users.append(User(model: userRM))
        }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SavedUsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath) as? UserTableViewCell
        cell?.user = users[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

extension SavedUsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

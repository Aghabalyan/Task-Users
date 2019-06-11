//
//  UsersViewController.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    private let userCell = "UserTableViewCell"
    private let showUserDetailsViewControllerSegue = "showUserDetailsViewControllerSegue"
    var users: [User] = []

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupNavBar()
        registerCell()
        getUsers(results: 40)
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
    
    // MARK: - Server request
    func getUsers(results: Int) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let form = UserForm(results: results)
        UsersService.shered.citiesResponse(data: form) { (usersResponseData) in
            switch usersResponseData {
            case .base(response: let baseResposne):
                CheckBaseHelper.checkBaseResponse(baseResposne, viewController: self)
            case .success(let resultsData):
                guard let users = resultsData.results else {return}
                self.users = users.filter({$0.userId != nil})
            case .isOffline:
                return
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath) as? UserTableViewCell
        cell?.user = users[indexPath.row]
        return cell ?? UITableViewCell()
    }
}

extension UsersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        vc.user = users[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

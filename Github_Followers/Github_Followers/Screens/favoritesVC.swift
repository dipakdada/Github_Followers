//
//  favoritesVC.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 27/09/24.
//

import UIKit

class favoritesVC: UIViewController {

    let tableView   = UITableView()
    var favourites  : [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }

    func getFavourites(){
        PersistenceManager.retriveFavourites { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let favourites):
                    if favourites.isEmpty {
                        showEmptyStateView(with: "No Favourites?\nAdd one from the Followers.", in: self.view)
                    } else {
                        self.favourites = favourites
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            self.view.bringSubviewToFront(self.tableView)
                        }
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    func configureViewController(){
        view.backgroundColor    = UIColor.systemBackground
        title                   = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        tableView.removeExcessCells() // Remove extra cells if present
        // register the custom cell into table view controller using a resable identifier
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseUD)
    }

}

extension favoritesVC: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseUD, for: indexPath) as! FavouriteCell
        cell.set(favourite: favourites[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Go to the followers page with username and title, to retrive all the followers of that user
        let favourite   = favourites[indexPath.row]
        let destVC      = FollowersListVC(username: favourite.login)
        navigationController?.pushViewController(destVC, animated: true)
    }

    // delegate method to remove the favourite user from favourites by using left swipe action
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }

        let favourite = favourites[indexPath.row]

        // delete the favourite user from the Persistence database which us userDefaults
        PersistenceManager.updateWith(favourite: favourite, actionType: .remove) { [weak self] error in
            guard let self  = self else { return }
            guard let error = error else {
                self.favourites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }

            self.presentGFAlertOnMainThread(title: "Unable to Remove", message: error.rawValue, buttonTitle: "OK")
        }
    }
}

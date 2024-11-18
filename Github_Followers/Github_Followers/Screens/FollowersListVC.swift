//
//  FollowersListVC.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 30/09/24.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowersListVC: UIViewController {

    enum Section {
        case main
    }

    var username : String!
    var followers : [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var filterdFollowers : [Follower] = []
    var isSearching = false
    var isLoadingMoreFollowers = false

    var collectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!

    init(username: String){
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchcontroller()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc func addButtonTap(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
                case .success(let user):
                    let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)

                    PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self] error in
                        guard let self = self else { return }

                        guard let error = error else {
                            self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully added this user to favourite ☄️", buttonTitle: "Hooray!")
                            return
                        }

                        self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "OK")
                    }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something Went Wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    // configure the current view controller
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // configure the collection view controller to render the followers list
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseUD)
    }

    func configureSearchcontroller(){
        // Search tab has been added to the navigationItem
        let searchController                                    = UISearchController()
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController

        // Add the user to favourite by using the plus button the top right corner
        let addButton   = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTap))
        navigationItem.rightBarButtonItem = addButton
    }

    // API call to get the all followers
    func getFollowers(username: String,page: Int) {
        // Show Loader uptil data is fetching from the API
        showLoadingView()
        isLoadingMoreFollowers = true

        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }

            // Dismissing Loader after data received from the API
            self.dismissLoadingView()

            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)

                    // Check if followers count is zero then show the custom screen that there is no followers for this user
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers. Go Follow them 🙁"
                        DispatchQueue.main.async {
                            self.showEmptyStateView(with: message, in: self.view)
                        }
                        return
                    }
                    
                    // update the collection view with followers
                    self.updateData(on: self.followers)
                case .failure(let error) :
                    self.presentGFAlertOnMainThread(title: "Bad stuff happen", message: error.rawValue, buttonTitle: "OK")
            }

            self.isLoadingMoreFollowers = false
        }
    }

    // The configureDataSource function you shared sets up a UICollectionViewDiffableDataSource for a collection view, allowing you to manage data in a declarative and efficient way.
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseUD, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }

    func updateData(on followers: [Follower]){
        // A new NSDiffableDataSourceSnapshot is created, specifying the section type (Section) and the item type (Follower).
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        // The main section is added to the snapshot with snapShot.appendSections([.main]).
        snapShot.appendSections([.main])
        // Then, the array of followers is appended as items to that section with snapShot.appendItems(followers).
        snapShot.appendItems(followers)
        // self.dataSource.apply(snapShot, animatingDifferences: true) applies the snapshot to the data source with animations.
        DispatchQueue.main.async { self.dataSource.apply(snapShot,animatingDifferences: true) }
    }
}

extension FollowersListVC: UICollectionViewDelegate {

    // triggerd this function when the user is reached to the end of the scroll view by calling scrollViewDidEndDragging delegate function of UICollectionViewDelegate
    // First we will find the scrolling height using (scrollView.contentOffset.y)
    // Then find the entire contents height rendered on the collection view by using (scrollView.contentSize.height)
    // Then find the height of the current height of the screen by using (scrollView.frame.size.height)
    // To triggered the function if offsetY > (contentSize - height)
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY     = scrollView.contentOffset.y
        let contentSize = scrollView.contentSize.height
        let height      = scrollView.frame.size.height

        if offsetY > (contentSize - height) {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }

    // This function triggered when user tap on the item in the collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // You need to check if the user is seraching anything or not, so that you will get the correct reference of the item
        let activeArray     = isSearching ? filterdFollowers : followers
        let follower        = activeArray[indexPath.row]
        
        let userVC          = UserInfoVC()
        userVC.username     = follower.login
        userVC.delegate     = self
        let navController   = UINavigationController(rootViewController: userVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC: UISearchResultsUpdating {

    // This function triggered when the username is enter into the search bar
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filterdFollowers.removeAll()
            self.updateData(on: followers)
            isSearching = false
            return
        }

        isSearching = true
        // filter the username by using filte function and based on username and put that values into filterdFollowers
        filterdFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}

        // Update the collection view with the filterd followers array
        self.updateData(on: filterdFollowers)
    }
}

extension FollowersListVC:FollowerListVCDelegate {

    func didRequestFollowers(for username: String) {
        // reset everything after calling get followers from the user info page
        self.username       = username
        title               = username
        self.page           = 1
        followers.removeAll()
        filterdFollowers.removeAll()
        // Move the screen view to the top of the screen, because we can be seeing the followers on the bottom of the screen
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        // Get all the followers of the user
        getFollowers(username: username, page: page)
    }
}

//
//  UserInfoVC.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 17/10/24.
//

import UIKit

// create your custom protocol and method inside them to triggered whenever you want
// I have create a protocol and two delegate method, so whenever if anyone conform to this protocol has to implement this method
protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class UserInfoVC: UIViewController {

    //MARK: Views
    let headerView              = UIView()
    let itemViewOne             = UIView()
    let itemViewTwo             = UIView()
    let dateLabel               = GFBodyLabel(textAlignment: .center)
    var itemsViews: [UIView]    = []

    //MARK: User defined variables
    var username : String = ""
    weak var delegate:FollowerListVCDelegate!

    //MARK: Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }

    //MARK: objc funtion
    // objectivec function to pass into selector
    @objc func dissmissVC(){
        dismiss(animated: true)
    }

    //MARK: User defined function
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let cancelBtn   = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dissmissVC))
        navigationController?.navigationBar.backgroundColor = traitCollection.userInterfaceStyle == .light ? .systemGray6 : .systemGray3
        navigationItem.rightBarButtonItem = cancelBtn
    }
    func getUserInfo(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let user):
                    dismissLoadingView()
                    DispatchQueue.main.async { self.configureUIElement(with: user) }

                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went Wrong😔", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    func configureUIElement(with user: User){

        let  repoItemVC         = GFRepoItemVC(user: user)
        repoItemVC.delegate     = self

        let followerItemVc      = GFFollowerItemVC(user: user)
        followerItemVc.delegate = self

        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVc, to: self.itemViewTwo)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }

    func layoutUI(){

        let padding: CGFloat    = 20
        let itemHeight:CGFloat  = 140

        itemsViews = [headerView,itemViewOne,itemViewTwo,dateLabel]

        for itemView in itemsViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor,constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension UserInfoVC: UserInfoVCDelegate {

    // open users github profile using safari services
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "OK")
            return
        }
        presentSafariVC(with: url)
    }
    
    // delegate method of custom protocol created by me to get the followers
    func didTapGetFollowers(for user: User) {
        guard user.followers > 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user don't have the followers 😔", buttonTitle: "OK")
            return
        }

        delegate.didRequestFollowers(for: user.login)
        dissmissVC()
    }
}

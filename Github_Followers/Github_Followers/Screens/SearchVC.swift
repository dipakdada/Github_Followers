//
//  SearchVC.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 27/09/24.
//

import UIKit

class SearchVC: UIViewController {

    let logoImage       = UIImageView()
    let usernameTF      = GFTextField()
    let getFollowersBtn = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var logoImageViewTopConstraint : NSLayoutConstraint!

    var isUsernameEntered : Bool { return !usernameTF.text!.isEmpty }

    var margin : CGFloat = 50

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureButton()
        creaeteDissmissKeyboardGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTF.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @objc func pushFollowerListVC(){
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😄.", buttonTitle: "OK")
            return
        }

        let followerListVC = FollowersListVC(username: usernameTF.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }

    func configureLogoImageView(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = Images.ghLogo

        // top constraint is based on the device
        let topCostraintConstant : CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topCostraintConstant).isActive = true

        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    func configureTextField(){
        view.addSubview(usernameTF)

        NSLayoutConstraint.activate([
            usernameTF.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 48),
            usernameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            usernameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            usernameTF.heightAnchor.constraint(equalToConstant: margin)
        ])
    }

    func configureButton(){
        view.addSubview(getFollowersBtn)
        getFollowersBtn.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)

        NSLayoutConstraint.activate([
            getFollowersBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            getFollowersBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margin),
            getFollowersBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
            getFollowersBtn.heightAnchor.constraint(equalToConstant: margin)
        ])
    }

    func creaeteDissmissKeyboardGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
}

extension SearchVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("did tap return : \(String(describing: textField.text))")
        return true
    }
}

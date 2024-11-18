//
//  UITableView-Ext.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 08/11/24.
//

import UIKit

extension UITableView {

    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}

//
//  UITableViewCell+Extension.swift
//  VKDonations
//
//  Created by Den Matyash on 11.09.2020.
//  Copyright © 2020 Den. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {

    class var nibName: String {
        return String(describing: self)
    }

    class var reuseIdentifier: String {
        return String(describing: self)
    }

    class func register(to tableView: UITableView) {
        tableView.register(UINib.init(nibName: self.nibName, bundle: nil), forCellReuseIdentifier: self.reuseIdentifier)
    }
}

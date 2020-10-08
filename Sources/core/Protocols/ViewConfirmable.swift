//
//  MasterView.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

protocol ViewConfirmable where Self: UIView {
    func setupView()
    func setupLayout()
}

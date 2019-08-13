//
//  MasterLabel.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

class MasterLabel: UILabel {
    enum `Type`: Int {
        case `default`
        case title
    }

    fileprivate var type: Type = Type.default

    init(Type type: Type = .default) {
        super.init(frame: .zero)
        self.type = type
        configure()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .default:
            font = Application.Fonts.Roboto.regular.of(size: 15.0)
            textColor = Application.Colors.black
        case .title:
            font = Application.Fonts.Roboto.regular.of(size: 25.0)
            textColor = Application.Colors.black
            numberOfLines = 0
        }
    }
}

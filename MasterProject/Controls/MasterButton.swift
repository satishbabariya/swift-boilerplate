//
//  MasterButton.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import Material
import UIKit

class MasterButton: Button {
    enum `Type` {
        case `default`
        case facebook
    }

    fileprivate var type: Type = Type.default

    init(Type type: Type = .default) {
        super.init(frame: .zero)
        self.type = type
        configure()
        setupLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .default, .facebook:
            backgroundColor = Application.Colors.red
            titleLabel?.font = Application.Fonts.Roboto.regular.of(size: 15.0)
            titleLabel?.textColor = Application.Colors.white
            setTitleColor(Application.Colors.white, for: UIControl.State.normal)
            clipsToBounds = true
        }
    }

    fileprivate func setupLayout() {
        var buttonHeight: CGFloat = 40
        switch type {
        default:
            buttonHeight = 40
        }
        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}

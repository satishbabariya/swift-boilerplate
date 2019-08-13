//
//  MasterTextField.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import Material
import UIKit

class MasterTextField: TextField {
    enum `Type` {
        case `default`
        case email
        case password
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
//        placeholderAnimation = .hidden
//        isDividerHidden = true
//        cornerRadiusPreset = .cornerRadius2
//        borderWidthPreset = .border2
//        borderColor = Application.Colors.lighestGray
//        backgroundColor = Application.Colors.clear
//        tintColor = Application.Colors.black
        font = Application.Fonts.Roboto.regular.of(size: 15.0)
//        textColor = Application.Colors.black
//        placeholderActiveColor = Application.Colors.lighestGray
//        placeholderNormalColor = Application.Colors.lighestGray
        textInset = 10.0

        switch type {
        case .default:
            keyboardType = .default
            isClearIconButtonEnabled = true

        case .email:
            keyboardType = .emailAddress
            autocorrectionType = .no
            autocapitalizationType = .none
            isClearIconButtonEnabled = true

        case .password:
            keyboardType = .default
            clearButtonMode = .whileEditing
            isSecureTextEntry = true
            isVisibilityIconButtonEnabled = true
//            self.visibilityIconButton?.tintColor =  Application.Colors.white.withAlphaComponent(self.isSecureTextEntry ? 0.38 : 0.54)
        }
    }

    fileprivate func setupLayout() {
        var buttonHeight: CGFloat = 38
        switch type {
        default:
            buttonHeight = 38
        }
        heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    }
}

//
//  MasterViewController.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import UIKit

class MasterViewController: UIViewController {
    // MARK: - Declarations -

    fileprivate var containerView: MasterView
    fileprivate var navigationTitle: String

    // MARK: - Lifecycle -

    init(with view: MasterView, title: String = "") {
        containerView = view
        navigationTitle = title
        super.init(nibName: nil, bundle: nil)
        setupView()
        setupLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods -

    fileprivate final func setupView() {
        navigationItem.title = navigationTitle
        view.backgroundColor = Application.Colors.white
        view.addSubview(containerView)
    }

    fileprivate final func setupLayout() {
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//
//  HomeController.swift
//  MasterProject
//
//  Created by Satish Babariya on 31/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

class HomeController: MasterViewController {
    // MARK: - Declarations -

    var homeView: HomeView

    // MARK: - Lifecycle -

    init() {
        homeView = .init()
        super.init(with: homeView, title: "Home")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  HomeView.swift
//  MasterProject
//
//  Created by Satish Babariya on 31/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation
import RxSwift

class HomeView: MasterView, ViewConfirmable {
    // MARK: - Declarations -

    // MARK: - Lifecycle -

    override init() {
        super.init()
        setupView()
        setupLayout()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Initializations -

    func setupView() {
        bindActivityIndicator()
        fetchUsers()
    }

    // MARK: - Layout -

    func setupLayout() {
//        let viewDictionary: [String: Any] = self.viewDictionary()
//        let metrics: [String: Any] = ["hSpace": 20, "secondHSpace": 30, "topSpace": 30, "bottomSpace": 20, "vSpace": 20]
//
//        addConstraints(withVisualFormat: "H:|-hSpace-[textfield]-hSpace-|", metrics: metrics, views: viewDictionary)
//        addConstraints(withVisualFormat: "V:|-vSpace-[textfield]-vSpace@256-|", metrics: metrics, views: viewDictionary)
    }

    // MARK: - Methods -

    // Sample Server Request
    fileprivate func fetchUsers() {
        RESTClient.users
            .request()
            .trackActivity(indicator)
            .observeOn(queue)
            .subscribe({ [weak self] response in
                guard let self = self else {
                    return
                }
                switch response {
                case let .next(meta, data):
                    self.displayMessage(message: meta.message, type: meta.type)
                    if let users: Users = data as? Users {
                        print(users.count)
                    }
                case let .error(error):
                    self.displayRestMessage(error: error)
                case .completed:
                    break
                }
            }).disposed(by: disposeBag)
    }
}

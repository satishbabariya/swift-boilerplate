//
//  MasterView.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Async
import Foundation
import NVActivityIndicatorView
import RxSwift
import SwiftMessages
import UIKit

protocol ViewConfirmable where Self: UIView {
    func setupView()
    func setupLayout()
}

class MasterView: UIView {
    // MARK: - Declarations -

    /// Its for maintaint the multipule API Call queue.
    lazy var queue: OperationQueueScheduler = OperationQueueScheduler(operationQueue: OperationQueue()) // OperationQueue = OperationQueue()

    /// Disposebag for Rx disposable Resources.
    private(set) var disposeBag: DisposeBag = DisposeBag()

    var indicator: ActivityIndicator = ActivityIndicator()

    /// Activity Indicator View
    var activityIndicatorView: NVActivityIndicatorView = NVActivityIndicatorView(frame: .zero)

    // MARK: - Lifecycle -

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        queue.operationQueue.cancelAllOperations()
    }

    // MARK: - Methods -

    fileprivate final func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Application.Colors.white
        initilizeActivityIndicator()
        bindActivityIndicator()
    }

    /// Deallocate and reuse disposebag
    func dispose() {
        disposeBag = DisposeBag()
    }
}

// MARK: - Rx Activity

extension MasterView {
    fileprivate var animating: AnyObserver<Bool> {
        return AnyObserver { [weak self] event in
            guard let self = self else {
                return
            }
            MainScheduler.ensureExecutingOnScheduler()
            switch event {
            case let .next(value):
                if value {
                    self.showProgress()
                } else {
                    self.hideProgress()
                }
            case let .error(error):
                Log.error(error.localizedDescription)
            case .completed:
                break
            }
        }
    }

    public func bindActivityIndicator() {
        indicator.asObservable().bind(to: animating).disposed(by: disposeBag)
    }
}

// MARK: - Progress

extension MasterView {
    func initilizeActivityIndicator() {
        activityIndicatorView.color = Application.Colors.black
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        activityIndicatorView.heightAnchor.constraint(equalTo: activityIndicatorView.widthAnchor).isActive = true
        isUserInteractionEnabled = false
        layoutSubviews()
    }

    public func showProgress() {
        activityIndicatorView.startAnimating()
    }

    public func hideProgress() {
        Async.main { [weak self] in
            guard let self = self else {
                return
            }
            self.activityIndicatorView.superview?.isUserInteractionEnabled = true
            self.activityIndicatorView.stopAnimating()
        }
    }
}

// MARK: - Message

extension MasterView {
    func displayMessage(message: String, type: Theme) {
        Async.main {
            MessageManager.show(message: message, position: .bottom, type: type)
        }
    }

    /// Show Rest Message
    ///
    /// - Parameter error: rest error
    func displayRestMessage(error: Error) {
        Async.main {
            if let error = error as? RESTError {
                MessageManager.show(message: error.message, position: .bottom, type: error.type)
            } else {
                MessageManager.show(message: "Something went wrong, please try again.", position: .bottom, type: .error)
            }
        }
    }
}

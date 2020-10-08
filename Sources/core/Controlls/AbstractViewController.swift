//
//  AbstractViewController.swift
//  Cloud Storage
//
//  Created by Satish Babariya on 25/11/19.
//  Copyright © 2019 Upsquare Solutions Private Limited. All rights reserved.
//

import RxSwift
import UIKit

class AbstractViewController: UIViewController {
    // MARK: - Attributes

    private(set) lazy var safeAreaView = UIView()
    private(set) lazy var queue = OperationQueueScheduler(operationQueue: OperationQueue())
//    private(set) lazy var indicator: ActivityIndicator = ActivityIndicator()
    private(set) var disposeBag = DisposeBag()

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        configure()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        configure()
    }

    deinit {
        queue.operationQueue.cancelAllOperations()
    }

    // MARK: - Configure Views

    func setupViews() {
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(safeAreaView)
    }

    // MARK: - Layout Views

    func setupLayout() {
        safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        safeAreaView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        safeAreaView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    // MARK: - Other Methods

    func configure() {
//        view.backgroundColor = view.isDarkMode ? .black : .gray
//        safeAreaView.backgroundColor = view.backgroundColor
    }

    func showProgress() {}
    func hideProgress() {}
}

// Copied form satishbabariya/swift-boilerplate

// MARK: - Rx Activity

extension AbstractViewController {
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

//    public func bindActivityIndicator() {
//        indicator.asObservable().bind(to: animating).disposed(by: disposeBag)
//    }
}

//
//  UICollectionView+Extensions.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

extension UICollectionViewCell {
    /// The reuse identifier to associate with the specified class. This parameter must not be nil and must not be an empty string.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    /// Register a class for use in creating new collection view cells.
    ///
    /// - Parameter _: The class of a cell that you want to use in the collection view.
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }

    /// Returns a reusable cell object located by its identifier
    ///
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// The data source receives this information when it is asked for the cell and should just pass it along.
    /// This method uses the index path to perform additional configuration based on the cell’s position in the collection view.
    /// - Returns: A valid UICollectionReusableView object.
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        return cell
    }
}

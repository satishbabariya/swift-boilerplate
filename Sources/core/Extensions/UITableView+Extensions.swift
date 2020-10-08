//
//  UITableView+Extensions.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// A string identifying the cell object to be reused. This parameter must not be nil.
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    /// Registers a class for use in creating new table cells.
    ///
    /// - Parameter _: The class of a cell that you want to use in the table (must be a UITableViewCell subclass).
    func register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    /// Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table.
    ///
    /// - Parameter indexPath: The index path specifying the location of the cell.
    /// The data source receives this information when it is asked for the cell and should just pass it along.
    /// This method uses the index path to perform additional configuration based on the cell’s position in the table view.
    /// - Returns: A UITableViewCell object with the associated reuse identifier. This method always returns a valid cell.
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not deque cell with identifier")
        }
        return cell
    }
}

//
//  UIView+Extensions.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

extension UIView {
    /// View Dictionary for VisualFormat
    ///
    /// - Returns: All subview View Dictionary
    func viewDictionary() -> [String: Any] {
        return Mirror(reflecting: self).children.reduce(into: [:]) { result, item in
            if let label = item.label, item.value is UIView {
                result[label] = item.value
            }
        }
    }

    /// Adds visual format  constraints on the layout of the receiving view or its subviews.
    ///
    /// - Parameters:
    ///   - withVisualFormat: visual format
    ///   - options: The format specification for the constraints. For more information, see Auto Layout Cookbook in Auto Layout Guide.
    ///   - metrics: describing the attribute and the direction of layout for all objects in the visual format string.
    ///   - views: A dictionary of views that appear in the visual format string.
    ///   The keys must be the string values used in the visual format string, and the values must be the view objects.
    func addConstraints(withVisualFormat: String,
                        options: NSLayoutConstraint.FormatOptions = NSLayoutConstraint.FormatOptions(rawValue: 0),
                        metrics: [String: Any]? = nil, views: [String: Any]) {
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withVisualFormat, options: options, metrics: metrics, views: views))
    }

    /// Expand view inside view
    ///
    /// "H:|-space-[view]-space-|"
    ///
    /// "V:|-space-[view]-space-|"
    ///
    /// - Parameters:
    ///   - view: view
    ///   - space: space in between
    func expand(view: UIView, space: Int = 0) {
        addConstraints(withVisualFormat: "H:|-space-[view]-space-|", metrics: ["space": space], views: ["view": view])
        addConstraints(withVisualFormat: "V:|-space-[view]-space-|", metrics: ["space": space], views: ["view": view])
    }
}

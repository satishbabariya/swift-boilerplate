//
//  UIView+Extensions.swift
//  satishbabariya/swift-boilerplate
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import UIKit

extension UIView {
    var isDarkMode: Bool {
        if #available(iOS 12.0, *), traitCollection.userInterfaceStyle == .dark {
            return true
        }
        return false
    }
}

extension UIViewController {
    /// View Dictionary for VisualFormat
    ///
    /// - Returns: All subview View Dictionary
    func viewDictionary() -> [String: Any] {
        return Mirror(reflecting: self).children.reduce(into: [:]) { result, item in
            if let label = item.label, item.value is UIView {
                if label.contains("$__lazy_storage_$_") {
                    result[label.replacingOccurrences(of: "$__lazy_storage_$_", with: "")] = item.value
                } else {
                    result[label] = item.value
                }
            }
        }
    }
}

extension UIView {
    /// View Dictionary for VisualFormat
    ///
    /// - Returns: All subview View Dictionary
    func viewDictionary() -> [String: Any] {
        return Mirror(reflecting: self).children.reduce(into: [:]) { result, item in
            if let label = item.label, item.value is UIView {
                if label.contains("$__lazy_storage_$_") {
                    result[label.replacingOccurrences(of: "$__lazy_storage_$_", with: "")] = item.value
                } else {
                    result[label] = item.value
                }
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
                        metrics: [String: Any]? = nil, views: [String: Any])
    {
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

    func expand(view: UIView, top: Int = 0, bottom: Int = 0, left: Int = 0, right: Int = 0) {
        let metrics = ["top": top, "bottom": bottom, "left": left, "right": right]
        addConstraints(withVisualFormat: "H:|-left-[view]-right-|", metrics: metrics, views: ["view": view])
        addConstraints(withVisualFormat: "V:|-top-[view]-bottom-|", metrics: metrics, views: ["view": view])
    }
}

extension UIApplication {
    class func getTopViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigation = controller as? UINavigationController {
            return getTopViewController(controller: navigation.visibleViewController)

        } else if let tabBar = controller as? UITabBarController, let selected = tabBar.selectedViewController {
            return getTopViewController(controller: selected)

        } else if let presented = controller?.presentedViewController {
            return getTopViewController(controller: presented)
        }
        return controller
    }
}

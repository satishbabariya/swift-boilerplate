//
//  Sequence+Extensions.swift
//  MasterProject
//
//  Created by Satish Babariya on 28/12/18.
//  Copyright © 2018 Satish Babariya. All rights reserved.
//

import Foundation

// struct Article {
//    let id: UUID
//    let source: URL
//    let title: String
//    let body: String
// }
//
// let articleIDs = articles.map(\.id)
// let articleSources = articles.map(\.source)
//
// playlist.songs.sorted(by: \.name)
// playlist.songs.sorted(by: \.dateAdded)
// playlist.songs.sorted(by: \.ratings.worldWide)
//
extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }

    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        return sorted { element, value in
            element[keyPath: keyPath] < value[keyPath: keyPath]
        }
    }
}

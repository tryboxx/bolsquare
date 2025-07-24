//
//  HasIdentifier.swift
//  bolsquare
//
//  Created by Christopher Kolodziej on 24/07/2025.
//

import UIKit

protocol HasIdentifier {
    static var identifier: String { get }
}

extension HasIdentifier {
    static var identifier: String {
        String(describing: self)
    }
}

extension HasIdentifier where Self: UITableViewCell {

    static func register(in tableView: UITableView) {
        tableView.register(Self.self, forCellReuseIdentifier: identifier)
    }

    static func cell(in tableView: UITableView) -> Self {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? Self
            else { fatalError("Tried to get unregistered cell: \(identifier)") }

        return cell
    }
}

extension HasIdentifier where Self: UICollectionViewCell {

    static func register(in collectionView: UICollectionView, forSpecificIndexPath indexPath: IndexPath? = nil) {
        collectionView.register(Self.self, forCellWithReuseIdentifier: identifierForIndexPath(indexPath))
    }

    static func identifierForIndexPath(_ indexPath: IndexPath?) -> String {
        indexPath.map { "\(self.identifier)_\($0)" } ?? identifier
    }

    static func registerNib(in collectionView: UICollectionView, forSpecificIndexPath indexPath: IndexPath? = nil) {
        let nib = UINib(nibName: String(describing: Self.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: identifierForIndexPath(indexPath))
    }

    static func cell(in collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> Self {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Self
            else { fatalError("Tried to get unregistered cell: \(identifier)") }
        return cell
    }

    static func cell(in collectionView: UICollectionView, forSpecificIndexPath indexPath: IndexPath) -> Self {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifierForIndexPath(indexPath),
                for: indexPath
            ) as? Self
            else { fatalError("Tried to get unregistered cell: \(identifier)") }
        return cell
    }
}

//
//  UIViewController + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

extension UIViewController {
	func configure<T: ConfigureCell, U: Hashable>(collectionView: UICollectionView,cellType: T.Type, with value: U , for indexPath: IndexPath) -> T {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifaer, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
		cell.configure(with: value)
		return cell
	}
}

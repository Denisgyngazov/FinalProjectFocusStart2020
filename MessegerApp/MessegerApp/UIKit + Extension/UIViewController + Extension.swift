//
//  UIViewController + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

extension UIViewController {

	//MARK: - Configure

	func configure<T: ConfigureCell, U: Hashable>(collectionView: UICollectionView,cellType: T.Type, with value: U , for indexPath: IndexPath) -> T {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.identifaer, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)") }
		cell.configure(with: value)
		return cell
	}
	//MARK: - AllertController
	
		func showAllertController(title: String, message: String, completion: @escaping () -> Void = { }) {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let acceptAction = UIAlertAction(title: "Continue", style: .default) { (_) in
				completion()
			}
			alertController.addAction(acceptAction)
			present(alertController, animated: true, completion: nil)
	}
}

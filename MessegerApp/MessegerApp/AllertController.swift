//
//  AllertController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import UIKit

final class AlertControl: UIViewController {
	func showAllertController(title: String, message: String, completion: @escaping () -> Void = { }) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let acceptAction = UIAlertAction(title: "Continue", style: .default) { (_) in
			completion()
		}
		alertController.addAction(acceptAction)
		present(alertController, animated: true, completion: nil)


	}
}

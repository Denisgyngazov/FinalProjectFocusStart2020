//
//  SetupProfileViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit
import FirebaseAuth

final class SetupProfileViewController: UIViewController {

	private let setupProfileView = SetupProfileView()
	private let alertControl = AlertControl()

	override func loadView() {
		self.view = setupProfileView
		setupActionButton()
	}

		private let currentUser: User

		init(currentUser: User) {
			self.currentUser = currentUser
			super.init(nibName: nil, bundle: nil)
}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

private extension SetupProfileViewController {
	func setupActionButton() {
		setupProfileView.comeinButton.addTarget(self, action: #selector(comeinButtonTapped), for: .touchUpInside)
	}
//&&
	@objc func comeinButtonTapped() {
		guard let email = currentUser.email else {return}

		FirestoreService.shared.saveProfileWith(
			id: currentUser.uid,
			email: email,
			username: setupProfileView.fullNameTextField.text,
			avataImageString: "nil",
			description:setupProfileView.aboutTextField.text,
			sex: setupProfileView.sexSegmentedControl.titleForSegment(at: setupProfileView.sexSegmentedControl.selectedSegmentIndex)) { (result) in

			switch result {

			case .success(let muser):
				self.showAllertController(title: "Sucess!", message: "Приятного общения!") {
					let mainTabBar = MainTabBarController(currentUser: muser)
					mainTabBar.modalPresentationStyle = .fullScreen
					self.present(mainTabBar, animated: true, completion: nil)
				}

			case .failure(let error):
				self.showAllertController(title: "Error!", message: error.localizedDescription)
			}
		}
	}
}

//MARK: - Alert controller
private extension SetupProfileViewController {
	func showAllertController(title: String, message: String, completion: @escaping () -> Void = { }) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let acceptAction = UIAlertAction(title: "Continue", style: .default) { (_) in
			completion()
		}
		alertController.addAction(acceptAction)
		present(alertController, animated: true, completion: nil)

	}
}

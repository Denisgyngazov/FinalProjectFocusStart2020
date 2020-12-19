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
	private let currentUser: User

	override func loadView() {
		self.view = setupProfileView
		setupActionButton()
	}


	init(currentUser: User) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)

		if let username = currentUser.displayName {
			setupProfileView.fullNameTextField.text = username
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}


}

//MARK: - Delegate navigation and picker controller

extension SetupProfileViewController: UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

		picker.dismiss(animated: true, completion: nil)
		guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
		setupProfileView.fillImageView.imageView.image = image
	}

}
//??

extension SetupProfileViewController: UIImagePickerControllerDelegate {

}
//MARK: - Setup action button

private extension SetupProfileViewController {
	func setupActionButton() {
		setupProfileView.comeinButton.addTarget(self, action: #selector(comeinButtonTapped), for: .touchUpInside)
		setupProfileView.fillImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
	}

	@objc func comeinButtonTapped() {
		guard let email = currentUser.email else {return}

		FirestoreService.shared.saveProfileWith(
			id: currentUser.uid,
			email: email,
			username: setupProfileView.fullNameTextField.text,
			avatarImage: setupProfileView.fillImageView.imageView.image,
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

	@objc func plusButtonTapped() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = .photoLibrary
		present(imagePickerController, animated: true, completion: nil)
	}
}



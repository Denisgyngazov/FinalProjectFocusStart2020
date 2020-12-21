//
//  ProfileViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit
import SDWebImage

final class ProfileViewController: UIViewController {

	private let profileView = ProfileView()
	private let user: MUser

	override func loadView() {
		self.view = profileView
		setupActionSend()
	}

	//MARK: - Init

	init(user: MUser) {
		self.user = user
		profileView.nameLabel.text = user.username
		profileView.aboutLabel.text = user.description
		let url = URL(string: user.avatarStringURL)
		profileView.imageView.sd_setImage(with: url, completed: nil)
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

	//MARK: - Setup action send

private extension ProfileViewController {
	func setupActionSend() {
		if let button = profileView.myTextFIeld.rightView as? UIButton {
			button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
		}
	}

	@objc func sendMessage() {
		guard let message = profileView.myTextFIeld.text, message.isEmpty == false else { return }
		self.dismiss(animated: true) {
			FirestoreService.shared.createWaitingChat(message: message, receiver: self.user) { (result) in
				switch result {

				case .success:
					UIApplication.getTopViewController()?.showAllertController(title: "Success!", message: "Your message for \(self.user.username) sent")
				case .failure(let error):
					UIApplication.getTopViewController()?.showAllertController(title: "Error!", message: error.localizedDescription)
				}
			}
		}
	}
}


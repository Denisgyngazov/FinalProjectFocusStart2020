//
//  SignUpViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SignUpViewController: UIViewController {

	private let singUpView = SingUpView()

	weak var delegate: AuthNavigationDelegate?

	override func loadView() {
		self.view = singUpView
		setupActionButton()
	}
}

private extension SignUpViewController {
	func setupActionButton() {
		singUpView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
	}
	@objc func loginButtonTapped() {
		self.dismiss(animated: true) {
			self.delegate?.toLoginViewController()
		}
	}
}



//
//  LoginViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit
import GoogleSignIn

final class LoginViewController: UIViewController {

	private let loginView = LoginView()

	weak var delegate: AuthNavigationDelegate?

	override func loadView() {
		self.view = loginView
		setupActionButton()

	}
}

private extension LoginViewController {
	func setupActionButton() {
		loginView.signUpButton.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
		loginView.googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
	}

	@objc func singUpButtonTapped() {
		dismiss(animated: true) {
			self.delegate?.toSignUpViewController()
		}
	}

	 @objc func googleButtonTapped() {
		GIDSignIn.sharedInstance()?.presentingViewController = self
		GIDSignIn.sharedInstance()?.signIn()
	}
}

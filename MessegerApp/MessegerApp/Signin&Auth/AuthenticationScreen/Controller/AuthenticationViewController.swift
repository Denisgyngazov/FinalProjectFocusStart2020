//
//  ViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

class AuthenticationViewController: UIViewController {

	private let authenticationView = AuthenticationView()

	private let signUpViewController = SignUpViewController()
	private let loginViewController = LoginViewController()

	override func loadView() {
		self.view = authenticationView

		setupActionButton()
		signUpViewController.delegate = self
		loginViewController.delegate = self

	}
}


extension AuthenticationViewController: AuthNavigationDelegate {
	func toLoginVC() {
		present(loginViewController, animated: true, completion: nil)
	}

	func toSignUpVC() {
		present(signUpViewController, animated: true, completion: nil)
	}
}

private extension AuthenticationViewController {
	func setupActionButton() {
		authenticationView.emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
		authenticationView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
	}

	@objc func emailButtonTapped() {
		present(signUpViewController, animated: true, completion: nil)
	}
	@objc func loginButtonTapped() {
		present(loginViewController, animated: true, completion: nil)
	}
}









//
//  LoginViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class LoginViewController: UIViewController {
	private let loginView = LoginView()

	weak var delegate: AuthNavigationDelegate?

	override func loadView() {
		self.view = loginView

		loginView.signUpButton.addTarget(self, action: #selector(action), for: .touchUpInside)
		


	}

}

private extension LoginViewController {
	@objc func action() {
		dismiss(animated: true) {
			self.delegate?.toSignUpVC()
		}
	}
}

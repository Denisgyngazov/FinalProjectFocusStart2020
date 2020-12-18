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
		singUpView.loginButton.addTarget(self, action: #selector(action), for: .touchUpInside)
	}
}

private extension SignUpViewController {
	@objc func action() {
		self.dismiss(animated: true) {
			self.delegate?.toLoginVC()
		}
	}
}



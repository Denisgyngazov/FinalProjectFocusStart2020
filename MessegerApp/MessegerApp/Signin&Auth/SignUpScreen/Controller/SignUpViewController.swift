//
//  SignUpViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SignUpViewController: UIViewController {

	//MARK: - Property

	private enum Metrics {
		static let titleSucessAllertControl: String = "Success!"
		static let messageSucessAllertControl: String = "You registered"
		static let titleErrorAllertControl: String = "Error!"
	}

	private let singUpView = SingUpView()
	weak var delegate: AuthNavigationDelegate?

	//MARK: - Life Cycle
	
	override func loadView() {
		self.view = singUpView
		setupActionButton()
	}
}
	//MARK: - Setup action button

private extension SignUpViewController {
	func setupActionButton() {
		singUpView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		singUpView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
	}
	@objc func loginButtonTapped() {
		self.dismiss(animated: true) {
			self.delegate?.toLoginViewController()
		}
	}
	@objc func signUpButtonTapped() {
		AuthenticationService.shared.register(email: singUpView.emailTextField.text,
											  password: singUpView.passwordTextField.text,
											  confirmPassword: singUpView.confirmPasswordTextField.text) { (result) in
			switch result {

			case .success(let user):
				self.showAllertController(title: Metrics.titleSucessAllertControl,
										  message: Metrics.messageSucessAllertControl) {
					self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
				}
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		}
	}
}




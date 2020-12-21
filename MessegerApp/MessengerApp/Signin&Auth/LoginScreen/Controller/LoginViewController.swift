//
//  LoginViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit
import GoogleSignIn

final class LoginViewController: UIViewController {

	//MARK: - Property

	private enum Metrics {
		static let titleSucessAllertControl: String = "Success!"
		static let messageSucessAllertControl: String = "You are logged in"
		static let titleErrorAllertControl: String = "Error!"
	}

	private let loginView = LoginView()
	weak var delegate: AuthNavigationDelegate?

	//MARK: - Init
	
	override func loadView() {
		self.view = loginView
		setupActionButton()
	}
}

	//MARK: - Setup action button

private extension LoginViewController {
	func setupActionButton() {
		loginView.signUpButton.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
		loginView.googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
		loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
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

	@objc func loginButtonTapped() {
		AuthenticationService.shared.login(email: loginView.emailTextField.text,
										   password: loginView.passwordTextField.text) { (result) in
			switch result {

			case .success(let user):
				self.showAllertController(title: Metrics.titleSucessAllertControl,
										  message: Metrics.messageSucessAllertControl) {
					FirestoreService.shared.getUserData(user: user) { (result) in
						switch result {

						case .success(let muser):
							let mainTabBar = MainTabBarController(currentUser: muser)
							mainTabBar.modalPresentationStyle = .fullScreen
							self.present(mainTabBar, animated: true, completion: nil)
						case .failure(_):
							self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
						}
					}

				}
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		}
	}
}

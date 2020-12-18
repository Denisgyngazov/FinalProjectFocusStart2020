//
//  ViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit
import GoogleSignIn

class AuthenticationViewController: UIViewController {

	private let authenticationView = AuthenticationView()

	private let signUpViewController = SignUpViewController()
	private let loginViewController = LoginViewController()

	override func loadView() {
		self.view = authenticationView

		setupActionButton()
		setupSiginLoginDelegate()
		setupGoogleDelegate()
	}
}

//MARK: - Google signInDelegate

extension AuthenticationViewController: GIDSignInDelegate {
	func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
		AuthenticationService.shared.googleLogin(user: user, error: error) { (result) in
			switch result {

			case .success(let user):
				FirestoreService.shared.getUserData(user: user) { (result) in
					switch result {

					case .success(let muser):
						let mainTabBar = MainTabBarController(currentUser: muser)
						mainTabBar.modalPresentationStyle = .fullScreen
						UIApplication.getTopViewController()!.present(mainTabBar, animated: true, completion: nil)
						
					case .failure(_):
						UIApplication.getTopViewController()!.showAllertController(title: "Succses", message: "Вы авторизованны") {
							UIApplication.getTopViewController()!.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
						}
					}
				}
			case .failure(let error):
				UIApplication.getTopViewController()!.showAllertController(title: "Error!", message: error.localizedDescription)
			}
		}
	}
}

//MARK: - Realization AuthNavigationDelegate

extension AuthenticationViewController: AuthNavigationDelegate {
	func toLoginViewController() {
		present(loginViewController, animated: true, completion: nil)
	}

	func toSignUpViewController() {
		present(signUpViewController, animated: true, completion: nil)
	}
}

//MARK: - Delegate Google

private extension AuthenticationViewController {
	func setupGoogleDelegate() {
		GIDSignIn.sharedInstance()?.delegate = self
	}
}

//MARK: - Delegate signin and login

private extension AuthenticationViewController {
	func setupSiginLoginDelegate() {
		signUpViewController.delegate = self
		loginViewController.delegate = self
	}
}

//MARK: - Setup action button

private extension AuthenticationViewController {
	func setupActionButton() {
		authenticationView.emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
		authenticationView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		authenticationView.googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
	}

	@objc func emailButtonTapped() {
		present(signUpViewController, animated: true, completion: nil)
	}
	@objc func loginButtonTapped() {
		present(loginViewController, animated: true, completion: nil)
	}

	@objc func googleButtonTapped() {
		GIDSignIn.sharedInstance()?.presentingViewController = self
		GIDSignIn.sharedInstance()?.signIn()
	}
}










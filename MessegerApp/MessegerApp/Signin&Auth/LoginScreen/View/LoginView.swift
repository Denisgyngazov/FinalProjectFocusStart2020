//
//  LoginView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class LoginView: UIView {

	private let helloLabel = UILabel(text: "Welcome back!",
									 font: .avenirTitle())

	private let googleLabel = UILabel(text: "Login with")
	private let orLabel = UILabel(text: "or")
	private let emailLabel = UILabel(text: "Email")
	private let passwordLabel = UILabel(text: "Password")
	private let newAccountLabel = UILabel(text: "Need an account?")
	private let googleButton = UIButton(title: Metrics.googleTitle,
								   titleColor: Metrics.googleTitleColor,
								   backgroundColor: Metrics.googleBackgroundColor,
								   font: Metrics.googleFont,
								   isShadow: Metrics.googleIsShadow,
								   cornerRadius: Metrics.googleCornerRadius)

	 private let loginButton = UIButton(title: Metrics.loginTitle,
									   titleColor: Metrics.loginTitleColor,
									   backgroundColor: Metrics.loginBackgroundColor,
									   font: Metrics.loginFont,
									   isShadow: Metrics.loginShadow,
									   cornerRadius: Metrics.loginCornerRadius)

	 let signUpButton = UIButton(title: "Sign up",
									   titleColor: .buttonRed(),
									   font: .avenirDefault())

	private let emailTextField = OneLineTextField(font: .avenirDefault())
	private let passwordTextField = OneLineTextField(font: .avenirDefault())

	//private let alertControl = AlertControl()


	private enum Metrics {
		static let googleTitle: String = "Google"
		static let googleFont: UIFont? = .avenirDefault()
		static let googleTitleColor: UIColor = .black
		static let googleBackgroundColor: UIColor = .white
		static let googleIsShadow: Bool = true
		static let googleCornerRadius: CGFloat = 4

		static let loginTitle: String = "Login"
		static let loginTitleColor: UIColor = .white
		static let loginBackgroundColor: UIColor = .buttonBlack()
		static let loginFont: UIFont? = .avenirDefault()
		static let loginShadow: Bool = false
		static let loginCornerRadius: CGFloat = 4
	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupGoogleImage()
		setupViewLayout()
		setupActionButton()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Setup Action button

private extension LoginView {
	func setupActionButton() {
		loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
		//signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
	}

	@objc func loginButtonTapped() {
		AuthenticationService.shared.login(email: emailTextField.text, password: passwordTextField.text) { (result) in
			switch result {

			case .success(let user):
				self.showAllertController(title: "Success!", message: "Are you log in") {
					FirestoreService.shared.getUserData(user: user) { (result) in
						switch result {

						case .success(let muser):
							let mainTabBar = MainTabBarController(currentUser: muser)
							mainTabBar.modalPresentationStyle = .fullScreen
							self.findViewController()?.present(mainTabBar, animated: true, completion: nil)
						case .failure(_):
							self.findViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
						}
					}

				}
			case .failure(let error):
				self.showAllertController(title: "Error!", message: error.localizedDescription)
			}
		}
	}

	@objc func signUpButtonTapped() {
		//findViewController()?.present(SignUpViewController(), animated: true , completion: nil)
		
	}
}

private extension LoginView {
	func showAllertController(title: String, message: String, completion: @escaping () -> Void = { }) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let acceptAction = UIAlertAction(title: "Continue", style: .default) { (_) in
			completion()
		}
		alertController.addAction(acceptAction)
		findViewController()?.present(alertController, animated: true, completion: nil)

	}
}

private extension LoginView {
	func setupGoogleImage() {
		googleButton.customizeGoogleButton()
	}
}

private extension LoginView {
	func setupViewLayout() {
		setupHelloLabel()
		setupGoogleLabel()
		setupGoogleButton()
		setupOrLabel()
		setupEmailLabel()
		setupEmailTextField()
		setupPasswordLabel()
		setupPasswordTextField()
		setupLoginButton()
		setupNewAccountLabel()
		setupSignUpButton()
	}

	func setupHelloLabel() {
		self.addSubview(helloLabel)
		helloLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			helloLabel.topAnchor.constraint(equalTo: self.topAnchor,
											constant: 100),
			helloLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor )
			])
	}

	func setupGoogleLabel() {
		self.addSubview(googleLabel)
		googleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor,
											  constant: 100),
			googleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
											  constant: 30)
		])
	}

	func setupGoogleButton() {
		self.addSubview(googleButton)
		googleButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleButton.topAnchor.constraint(equalTo: googleLabel.bottomAnchor,
											  constant: 20),
			googleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: 30),
			googleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -30)
		])
}
	func setupOrLabel() {
		self.addSubview(orLabel)
		orLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			orLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor,
											  constant: 50),
			orLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
											  constant: 30)
		])
	}

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 50),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupEmailTextField() {
		self.addSubview(emailTextField)
		emailTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
			emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)


		])
	}


	func setupPasswordLabel() {
		self.addSubview(passwordLabel)
		passwordLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
			passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupPasswordTextField() {
		self.addSubview(passwordTextField)
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
			passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)

		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
											 constant: 20),
			loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: 30),
			loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -30)
		])
	}

	func setupNewAccountLabel() {
		self.addSubview(newAccountLabel)
		newAccountLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			newAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
			newAccountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupSignUpButton() {
		self.addSubview(signUpButton)
		signUpButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
			signUpButton.leadingAnchor.constraint(equalTo: newAccountLabel.trailingAnchor, constant: 15)
		])
	}
}
	

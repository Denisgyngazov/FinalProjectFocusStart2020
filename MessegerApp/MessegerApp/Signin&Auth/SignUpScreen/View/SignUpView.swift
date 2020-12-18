//
//  SignUpView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SingUpView: UIView {

//MARK: - View
	private let helloLabel = UILabel(text: "Welcome!",
									 font: .avenirTitle())

	private let emailLabel = UILabel(text: "Email")
	private let passwordLabel = UILabel(text: "Password")
	private let confirmPasswordLabel = UILabel(text: "Confirm pasword")
	private let loginLabel = UILabel(text: "Already registered?")

	private let signUpButton = UIButton(title: "Sign up",
										titleColor: .white,
										backgroundColor: .buttonBlack(),
										font: .avenirDefault(),
										isShadow: false,
										cornerRadius: 4)

	 let loginButton = UIButton(title: "Login",
									   titleColor: .buttonRed(),
									   font: .avenirDefault())
	

	private let emailTextField = OneLineTextField(font: .avenirDefault())
	private let passwordTextField = OneLineTextField(font: .avenirDefault())
	private let confirmPasswordTextField = OneLineTextField(font: .avenirDefault())

	//private let alertControl = AlertControl()

	

//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white

		setupViewLayout()
		setupActionButton()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension SingUpView {
	func setupActionButton() {
		signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
		//loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
	}

	@objc func signUpButtonTapped() {
		AuthenticationService.shared.register(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text) { (result) in
			switch result {

			case .success(let user):
				self.showAllertController(title: "Success!", message: "Are you resistered") {
					self.findViewController()?.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
				}
			case .failure(let error):
				self.showAllertController(title: "Error!", message: error.localizedDescription)
			}
		}
	}

//	@objc func loginButtonTapped() {
//		//findViewController()?.present(LoginViewController(), animated: true, completion: nil)
//	}
}

//MARK: - Alert controller
private extension SingUpView {
	func showAllertController(title: String, message: String, completion: @escaping () -> Void = { }) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let acceptAction = UIAlertAction(title: "Continue", style: .default) { (_) in
			completion()
		}
		alertController.addAction(acceptAction)
		findViewController()?.present(alertController, animated: true, completion: nil)

	}
}

private extension SingUpView {
	func setupViewLayout() {
		setupHelloLabel()
		setupEmailLabel()
		setupEmailTextField()
		setupPasswordLabel()
		setupPasswordTextField()
		setupConfirmPasswordLabel()
		setupConfirmPasswordTextField()
		setupSignUpButton()
		setupLoginLabel()
		setupLoginButton()
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

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 100),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupEmailTextField() {
		self.addSubview(emailTextField)
		emailTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
			emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),


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
			passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),

		])
	}

	func setupConfirmPasswordLabel() {
		self.addSubview(confirmPasswordLabel)
		confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
			confirmPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])

	}

	func setupConfirmPasswordTextField() {
		self.addSubview(confirmPasswordTextField)
		confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 20),
			confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),

		])
	}

	func setupSignUpButton() {
		self.addSubview(signUpButton)
		signUpButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor,
											constant: 30),

			signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: 30),
			signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -30)
			])
	}

	func setupLoginLabel() {
		self.addSubview(loginLabel)
		loginLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 30),
			loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
			loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor, constant: 15)
		])
	}
}


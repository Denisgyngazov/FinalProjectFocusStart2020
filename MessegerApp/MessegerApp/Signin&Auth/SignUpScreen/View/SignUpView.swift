//
//  SignUpView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SingUpView: UIView {

	//MARK: - Property

	private enum Metrics {
		static let helloLabelTitle: String = "Welcome!"
		static let emailLabelTitle: String = "Email"
		static let passwordLabelTitle: String = "Password"
		static let confirmPasswordLabelTitle: String = "Confirm password"
		static let loginTextLabel: String = "Already registered?"
		static let signUpButtonTitle: String = "Sign up"
		static let loginButtonTitle: String = "Login"

		static let signUpButtonTitleColor: UIColor = .white
		static let signUpButtonIsShadow: Bool = false
		static let signUpButtonCornerRadius: CGFloat = 4
	}

	private enum Layout {
		static let helloAndEmailLabelTopAnchor: CGFloat = 50
		static let leadingAndTrailingAnchor: CGFloat = 30
		static let labelTopAnchor: CGFloat = 20
		static let loginButtonTopAnchor: CGFloat = 15
		static let loginButtonLeadingAnchor: CGFloat = 15
	}

	//MARK: - View
	
	private let helloLabel = UILabel(text: Metrics.helloLabelTitle,
									 font: .avenirTitle())

	private let emailLabel = UILabel(text: Metrics.emailLabelTitle)
	private let passwordLabel = UILabel(text: Metrics.passwordLabelTitle)
	private let confirmPasswordLabel = UILabel(text: Metrics.confirmPasswordLabelTitle)
	private let loginLabel = UILabel(text: Metrics.loginTextLabel)

	let signUpButton = UIButton(title: Metrics.signUpButtonTitle,
								titleColor: Metrics.signUpButtonTitleColor,
								backgroundColor: .buttonBlack(),
								font: .avenirDefault(),
								isShadow: Metrics.signUpButtonIsShadow,
								cornerRadius: Metrics.signUpButtonCornerRadius)

	let loginButton = UIButton(title: Metrics.loginButtonTitle,
							   titleColor: .buttonRed(),
							   font: .avenirDefault())

	let emailTextField = OneLineTextField(font: .avenirDefault())
	let passwordTextField = OneLineTextField(font: .avenirDefault())
	let confirmPasswordTextField = OneLineTextField(font: .avenirDefault())

	//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

	//MARK: - Layout

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
			helloLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
											constant: Layout.helloAndEmailLabelTopAnchor),
			helloLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor,
											constant: Layout.helloAndEmailLabelTopAnchor),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupEmailTextField() {
		self.addSubview(emailTextField)
		emailTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,
												constant: Layout.labelTopAnchor),
			emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													constant: Layout.leadingAndTrailingAnchor),
			emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
													 constant: -Layout.leadingAndTrailingAnchor),
		])
	}

	func setupPasswordLabel() {
		self.addSubview(passwordLabel)
		passwordLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
											   constant: Layout.labelTopAnchor),
			passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												   constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupPasswordTextField() {
		self.addSubview(passwordTextField)
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,
												   constant: Layout.labelTopAnchor),
			passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													   constant: Layout.leadingAndTrailingAnchor),
			passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														constant: -Layout.leadingAndTrailingAnchor),
		])
	}

	func setupConfirmPasswordLabel() {
		self.addSubview(confirmPasswordLabel)
		confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			confirmPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
													  constant: Layout.labelTopAnchor),
			confirmPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
														  constant: Layout.leadingAndTrailingAnchor)
		])

	}

	func setupConfirmPasswordTextField() {
		self.addSubview(confirmPasswordTextField)
		confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor,
														  constant: Layout.labelTopAnchor),
			confirmPasswordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
															  constant: Layout.leadingAndTrailingAnchor),
			confirmPasswordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
															   constant: -Layout.leadingAndTrailingAnchor),
		])
	}

	func setupSignUpButton() {
		self.addSubview(signUpButton)
		signUpButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor,
											  constant: Layout.labelTopAnchor),
			signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: Layout.leadingAndTrailingAnchor),
			signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -Layout.leadingAndTrailingAnchor)
		])
	}

	func setupLoginLabel() {
		self.addSubview(loginLabel)
		loginLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor,
											constant: Layout.labelTopAnchor),
			loginLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor,
											 constant: Layout.loginButtonTopAnchor),
			loginButton.leadingAnchor.constraint(equalTo: loginLabel.trailingAnchor,
												 constant: Layout.loginButtonLeadingAnchor)
		])
	}
}


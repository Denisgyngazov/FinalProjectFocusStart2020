//
//  LoginView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class LoginView: UIView {

	//MARK: - Property

	private enum Metrics {
		static let helloLabel: String = "Welcome back!"
		static let googleLabel: String = "Login with"
		static let googleTitle: String = "Google"
		static let orLabel: String = "or"
		static let emailLabel: String = "Email"
		static let passwordLabel: String = "Password"
		static let newAccountLabel: String = "Need an account?"
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

		static let signUpButtonTitle: String = "Sign up"
	}

	private enum Layout {
		static let helloLabelTopAnchor: CGFloat = 50
		static let googleLabelTopAnchor: CGFloat = 50
		static let leadingAndTrailingAnchor: CGFloat = 30
		static let topAnchorLabel: CGFloat = 20
		static let signUpButtonTopAnchor: CGFloat = 13
		static let signUpButtonLeadingAnchor: CGFloat = 15

	}

	//MARK: - View

	private let helloLabel = UILabel(text: Metrics.helloLabel,
									 font: .avenirTitle())
	private let googleLabel = UILabel(text: Metrics.googleLabel)
	private let orLabel = UILabel(text: Metrics.orLabel)
	private let emailLabel = UILabel(text: Metrics.emailLabel)
	private let passwordLabel = UILabel(text: Metrics.passwordLabel)
	private let newAccountLabel = UILabel(text: Metrics.newAccountLabel)
	let googleButton = UIButton(title: Metrics.googleTitle,
										titleColor: Metrics.googleTitleColor,
										backgroundColor: Metrics.googleBackgroundColor,
										font: Metrics.googleFont,
										isShadow: Metrics.googleIsShadow,
										cornerRadius: Metrics.googleCornerRadius)
	let loginButton = UIButton(title: Metrics.loginTitle,
									   titleColor: Metrics.loginTitleColor,
									   backgroundColor: Metrics.loginBackgroundColor,
									   font: Metrics.loginFont,
									   isShadow: Metrics.loginShadow,
									   cornerRadius: Metrics.loginCornerRadius)

	let signUpButton = UIButton(title: Metrics.signUpButtonTitle,
								titleColor: .buttonRed(),
								font: .avenirDefault())

	let emailTextField = OneLineTextField(font: .avenirDefault())
	let passwordTextField = OneLineTextField(font: .avenirDefault())

	//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupGoogleImage()
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Setup google image

private extension LoginView {
	func setupGoogleImage() {
		googleButton.customizeGoogleButton()
	}
}

//MARK: - Layout

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
			helloLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
											constant: Layout.helloLabelTopAnchor),
			helloLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor )
		])
	}

	func setupGoogleLabel() {
		self.addSubview(googleLabel)
		googleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleLabel.topAnchor.constraint(equalTo: helloLabel.bottomAnchor,
											 constant: Layout.googleLabelTopAnchor),
			googleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupGoogleButton() {
		self.addSubview(googleButton)
		googleButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleButton.topAnchor.constraint(equalTo: googleLabel.bottomAnchor,
											  constant: Layout.topAnchorLabel),
			googleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: Layout.leadingAndTrailingAnchor),
			googleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -Layout.leadingAndTrailingAnchor)
		])
	}
	func setupOrLabel() {
		self.addSubview(orLabel)
		orLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			orLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor,
										 constant: Layout.topAnchorLabel),
			orLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
											 constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: orLabel.bottomAnchor,
											constant: Layout.topAnchorLabel),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupEmailTextField() {
		self.addSubview(emailTextField)
		emailTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,
												constant: Layout.topAnchorLabel),
			emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													constant: Layout.leadingAndTrailingAnchor),
			emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
													 constant: -Layout.leadingAndTrailingAnchor)
		])
	}


	func setupPasswordLabel() {
		self.addSubview(passwordLabel)
		passwordLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,
											   constant: Layout.topAnchorLabel),
			passwordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												   constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupPasswordTextField() {
		self.addSubview(passwordTextField)
		passwordTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor,
												   constant: Layout.topAnchorLabel),
			passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													   constant: Layout.leadingAndTrailingAnchor),
			passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														constant: -Layout.leadingAndTrailingAnchor)

		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
											 constant: Layout.topAnchorLabel),
			loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.leadingAndTrailingAnchor),
			loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -Layout.leadingAndTrailingAnchor)
		])
	}

	func setupNewAccountLabel() {
		self.addSubview(newAccountLabel)
		newAccountLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			newAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
												 constant: Layout.topAnchorLabel),
			newAccountLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													 constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupSignUpButton() {
		self.addSubview(signUpButton)
		signUpButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
											  constant: Layout.signUpButtonTopAnchor),
			signUpButton.leadingAnchor.constraint(equalTo: newAccountLabel.trailingAnchor,
												  constant: Layout.signUpButtonLeadingAnchor)
		])
	}
}


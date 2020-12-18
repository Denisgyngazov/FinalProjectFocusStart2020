//
//  AuthenticationView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

final class AuthenticationView: UIView {

 //MARK: - View

	private let logoLabel = UILabel (text: "Messenger", font: .avenirTitle())
	private let googleLabel = UILabel(text: "Get started with")
	private let emailLabel = UILabel(text: "Or sign up with")
	private let logindLabel = UILabel(text: "Already registered?")
	private let logoImageView = UIImageView(image: #imageLiteral(resourceName: "logo"), contentMode: .scaleAspectFit)

	 let emailButton = UIButton(title: Metrics.emailTitle,
								   titleColor: Metrics.emailTitleColor,
								   backgroundColor: Metrics.emailBackgroundColor,
								   font: Metrics.emailFont,
								   isShadow: Metrics.emailIsShadow,
								   cornerRadius: Metrics.emailCornerRadius)

	 let loginButton = UIButton(title: Metrics.loginTitle,
								   titleColor: Metrics.loginTitleColor,
								   backgroundColor: Metrics.loginBackgroundColor,
								   font: Metrics.loginFont,
								   isShadow: Metrics.loginIsShadow,
								   cornerRadius: Metrics.loginCornerRadius)

	private let googleButton = UIButton(title: Metrics.googleTitle,
								   titleColor: Metrics.googleTitleColor,
								   backgroundColor: Metrics.googleBackgroundColor,
								   font: Metrics.googleFont,
								   isShadow: Metrics.googleIsShadow,
								   cornerRadius: Metrics.googleCornerRadius)

//MARK: - Property
//	private let signUpViewController = SignUpViewController()
//	private let loginViewController = LoginViewController()


	private enum Metrics {

//MARK: - Button propertys

		static let emailTitle: String = "Email"
		static let emailTitleColor: UIColor = .white
		static let emailBackgroundColor: UIColor = .buttonBlack()
		static let emailFont: UIFont? = .avenirDefault()
		static let emailIsShadow: Bool = false
		static let emailCornerRadius: CGFloat = 4

		static let loginTitle: String = "Login"
		static let loginTitleColor: UIColor = .buttonRed()
		static let loginFont: UIFont? = .avenirDefault()
		static let loginBackgroundColor: UIColor = .white
		static let loginIsShadow: Bool = true
		static let loginCornerRadius: CGFloat = 4

		static let googleTitle: String = "Google"
		static let googleFont: UIFont? = .avenirDefault()
		static let googleTitleColor: UIColor = .black
		static let googleBackgroundColor: UIColor = .white
		static let googleIsShadow: Bool = true
		static let googleCornerRadius: CGFloat = 4

//MARK: - Layout propertys

		static let logoImageViewTopAnchor: CGFloat = 160
		static let logoImageViewWidthAnchor: CGFloat = 50
		static let logoImageViewHeighthAnchor: CGFloat = 50
		static let logoImageViewCenterXAnchor: CGFloat = 70

		static let logoLabelTopAnchor: CGFloat = 170
		static let logoLabelTrailingAnchor: CGFloat = 40

		static let googleLabelTopAnchor: CGFloat = 100
		static let googleLabelLeadingAnchor: CGFloat = 30
		static let buttonTopAnchor: CGFloat = 20
		static let buttonleadingAndTrailingAnchor: CGFloat = 30
		static let buttonHeightAnchor: CGFloat = 50

		static let otherLabelTopAnchor: CGFloat = 50
		static let otherLabelLeadingAnchor: CGFloat = 30

	}

//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white

		setupGoogleImage()
		setupViewLayout()
		//setupActionButton()

		//signUpViewController.delegate = self
		//loginViewController.delegate = self

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Setup Action button

private extension AuthenticationView {
	func setupActionButton() {
		emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
		loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
	}

	@objc func emailButtonTapped() {
		findViewController()?.present(SignUpViewController(), animated: true, completion: nil)
	}
	@objc func loginButtonTapped() {
		findViewController()?.present(LoginViewController(), animated: true, completion: nil)
	}
}

//MARK: - Setup Google image

private extension AuthenticationView {
	func setupGoogleImage() {
		googleButton.customizeGoogleButton()
	}
}

//MARK: - Layout

private extension AuthenticationView {
	func setupViewLayout() {
		setupViewlogoLabel()
		setupLogoLabel()
		setupGoogleLabel()
		setupGoogleButton()
		setupEmailLabel()
		setupEmailButton()
		setupLoginLabel()
		setupLoginButton()
	}

	func setupViewlogoLabel() {
		self.addSubview(logoImageView)
		logoImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			logoImageView.topAnchor.constraint(equalTo: self.topAnchor,
											   constant: Metrics.logoImageViewTopAnchor),
			logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor,
												   constant: Metrics.logoImageViewCenterXAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: Metrics.logoImageViewWidthAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: Metrics.logoImageViewHeighthAnchor)
		])
	}

	func setupLogoLabel() {
		self.addSubview(logoLabel)
		logoLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			logoLabel.topAnchor.constraint(equalTo: self.topAnchor,
										   constant: Metrics.logoLabelTopAnchor),
			logoLabel.trailingAnchor.constraint(equalTo: logoImageView.centerXAnchor,
												constant: -Metrics.logoLabelTrailingAnchor)
		])
	}

	func setupGoogleLabel() {
		self.addSubview(googleLabel)
		googleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor,
											 constant: Metrics.googleLabelTopAnchor),
			googleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Metrics.googleLabelLeadingAnchor)
		])
	}

	func setupGoogleButton() {
		self.addSubview(googleButton)
		googleButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleButton.topAnchor.constraint(equalTo: googleLabel.bottomAnchor,
											  constant: Metrics.buttonTopAnchor),
			googleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: Metrics.buttonleadingAndTrailingAnchor),
			googleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -Metrics.buttonleadingAndTrailingAnchor),
			//googleButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeightAnchor)
		])
	}

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor,
											constant: Metrics.otherLabelTopAnchor),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Metrics.otherLabelLeadingAnchor),
		])
	}

	func setupEmailButton() {
		self.addSubview(emailButton)
		emailButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emailButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,
											 constant: Metrics.buttonTopAnchor),
			emailButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Metrics.buttonleadingAndTrailingAnchor),
			emailButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -Metrics.buttonleadingAndTrailingAnchor),
			//emailButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeightAnchor)
		])
	}

	func setupLoginLabel() {
		self.addSubview(logindLabel)
		logindLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			logindLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor,
													 constant: Metrics.otherLabelTopAnchor),
			logindLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
														 constant: Metrics.otherLabelLeadingAnchor)
		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: logindLabel.bottomAnchor,
											 constant: Metrics.buttonTopAnchor),
			loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Metrics.buttonleadingAndTrailingAnchor),
			loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -Metrics.buttonleadingAndTrailingAnchor),
			//loginButton.heightAnchor.constraint(equalToConstant: Metrics.buttonHeightAnchor)
		])
	}
}



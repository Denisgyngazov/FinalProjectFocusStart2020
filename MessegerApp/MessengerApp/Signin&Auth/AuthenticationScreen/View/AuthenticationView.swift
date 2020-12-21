//
//  AuthenticationView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

final class AuthenticationView: UIView {

	private enum Metrics {
		static let logoLabelText: String = "Messenger"
		static let googleLabelText: String = "Get started with"
		static let emailLabelText: String = "Or sign up with"
		static let loginLableText: String = "Already registered?"
		static let logoImageView: UIImage = #imageLiteral(resourceName: "logo")


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

	}
	private enum Layout {
		static let logoImageViewTopAnchor: CGFloat = 50
		static let logoImageViewWidthAnchor: CGFloat = 50
		static let logoImageViewHeighthAnchor: CGFloat = 50
		static let logoImageViewCenterXAnchor: CGFloat = 70

		static let logoLabelTopAnchor: CGFloat = 60
		static let logoLabelTrailingAnchor: CGFloat = 40

		static let buttonTopAnchor: CGFloat = 20
		static let buttonleadingAndTrailingAnchor: CGFloat = 30
		static let buttonHeightAnchor: CGFloat = 50

		static let labelTopAnchor: CGFloat = 50
		static let labelLeadingAnchor: CGFloat = 30

	}

	//MARK: - View

	private let logoLabel = UILabel (text: Metrics.logoLabelText,
									 font: .avenirTitle())
	private let googleLabel = UILabel(text: Metrics.googleLabelText)
	private let emailLabel = UILabel(text: Metrics.emailLabelText)
	private let logindLabel = UILabel(text: Metrics.loginLableText)
	private let logoImageView = UIImageView(image: Metrics.logoImageView,
											contentMode: .scaleAspectFit)

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

	let googleButton = UIButton(title: Metrics.googleTitle,
								titleColor: Metrics.googleTitleColor,
								backgroundColor: Metrics.googleBackgroundColor,
								font: Metrics.googleFont,
								isShadow: Metrics.googleIsShadow,
								cornerRadius: Metrics.googleCornerRadius)

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
			logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
											   constant: Layout.logoImageViewTopAnchor),
			logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor,
												   constant: Layout.logoImageViewCenterXAnchor),
			logoImageView.widthAnchor.constraint(equalToConstant: Layout.logoImageViewWidthAnchor),
			logoImageView.heightAnchor.constraint(equalToConstant: Layout.logoImageViewHeighthAnchor)
		])
	}

	func setupLogoLabel() {
		self.addSubview(logoLabel)
		logoLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			logoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
										   constant: Layout.logoLabelTopAnchor),
			logoLabel.trailingAnchor.constraint(equalTo: logoImageView.centerXAnchor,
												constant: -Layout.logoLabelTrailingAnchor)
		])
	}

	func setupGoogleLabel() {
		self.addSubview(googleLabel)
		googleLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor,
											 constant: Layout.labelTopAnchor),
			googleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.labelLeadingAnchor)
		])
	}

	func setupGoogleButton() {
		self.addSubview(googleButton)
		googleButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			googleButton.topAnchor.constraint(equalTo: googleLabel.bottomAnchor,
											  constant: Layout.buttonTopAnchor),
			googleButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: Layout.buttonleadingAndTrailingAnchor),
			googleButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -Layout.buttonleadingAndTrailingAnchor),
		])
	}

	func setupEmailLabel() {
		self.addSubview(emailLabel)
		emailLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emailLabel.topAnchor.constraint(equalTo: googleButton.bottomAnchor,
											constant: Layout.labelTopAnchor),
			emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Layout.labelLeadingAnchor),
		])
	}

	func setupEmailButton() {
		self.addSubview(emailButton)
		emailButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			emailButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,
											 constant: Layout.buttonTopAnchor),
			emailButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.buttonleadingAndTrailingAnchor),
			emailButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -Layout.buttonleadingAndTrailingAnchor),
		])
	}

	func setupLoginLabel() {
		self.addSubview(logindLabel)
		logindLabel.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			logindLabel.topAnchor.constraint(equalTo: emailButton.bottomAnchor,
											 constant: Layout.labelTopAnchor),
			logindLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.labelLeadingAnchor)
		])
	}

	func setupLoginButton() {
		self.addSubview(loginButton)
		loginButton.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			loginButton.topAnchor.constraint(equalTo: logindLabel.bottomAnchor,
											 constant: Layout.buttonTopAnchor),
			loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												 constant: Layout.buttonleadingAndTrailingAnchor),
			loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												  constant: -Layout.buttonleadingAndTrailingAnchor),
		])
	}
}

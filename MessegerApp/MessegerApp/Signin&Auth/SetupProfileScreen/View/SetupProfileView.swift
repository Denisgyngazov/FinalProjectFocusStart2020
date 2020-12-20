//
//  SetupProfileView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit
import FirebaseAuth

final class SetupProfileView: UIView {

	//MARK: - Property

	private enum Metrics {
		static let profileTextLabel: String = "Set up profile"
		static let fullNameTextLabel: String = "Full name"
		static let aboutTextLabel: String = "About me"
		static let sexTextLabel: String = "Sex"
		static let firstSegment: String = "Male"
		static let secondSegment: String = "Female"
		static let comeinButtonTitle: String = "To come in"

		static let comeinButtonTitleColor: UIColor = .white
		static let comeinButtonIsShadow: Bool = false
		static let comeinButtonCornerRadius: CGFloat = 4
	}

	private enum Layout {
		static let profileLabelTopAnchor: CGFloat = 100
		static let fillImageViewTopAnchor: CGFloat = 30
		static let fullNameLabelTopAnchor: CGFloat = 30
		static let textFieldTopAnchor: CGFloat = 20
		static let leadingAndTrailingAnchor: CGFloat = 30
		static let aboutLabelTopAnchor: CGFloat = 30
		static let sexLabelTopAnchor: CGFloat = 20
		static let sexSegmentTopAnchor: CGFloat = 20
		static let comeInButtonTopAnchor: CGFloat = 50
	}

	//MARK: - View

	let fillImageView = AddPhotoView()
	private let profileLabel = UILabel(text: Metrics.profileTextLabel,
									   font: .avenirTitle())
	private let fullNameLabel = UILabel(text: Metrics.fullNameTextLabel)
	private let aboutLabel = UILabel(text: Metrics.aboutTextLabel)
	private let sexLabel = UILabel(text: Metrics.sexTextLabel)
	let fullNameTextField = OneLineTextField(font: .avenirDefault())
	let aboutTextField = OneLineTextField(font: .avenirDefault())
	let sexSegmentedControl = UISegmentedControl(first: Metrics.firstSegment,
												 second: Metrics.secondSegment)
    let comeinButton = UIButton(title: Metrics.comeinButtonTitle,
								titleColor: Metrics.comeinButtonTitleColor,
										backgroundColor: .buttonBlack(),
										font: .avenirDefault(),
										isShadow: Metrics.comeinButtonIsShadow,
										cornerRadius: Metrics.comeinButtonCornerRadius)
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

private extension SetupProfileView {
	func setupViewLayout() {
		setupProfileLabel()
		setupFillImageView()
		setupFullNameLabel()
		setupFullNameTextField()
		setupAboutLabel()
		setupAboutTextField()
		setupSexLabel()
		setupSexSegmentedControl()
		setupComeinButton()
	}

	func setupProfileLabel() {
		self.addSubview(profileLabel)
		profileLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			profileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
											  constant: Layout.profileLabelTopAnchor),
			profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
			])
		}

	func setupFillImageView() {
		self.addSubview(fillImageView)
		fillImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fillImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,
											   constant: Layout.fillImageViewTopAnchor),
			fillImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor )
			])
	}

	func setupFullNameLabel() {
		self.addSubview(fullNameLabel)
		fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fullNameLabel.topAnchor.constraint(equalTo: fillImageView.bottomAnchor,
											   constant: Layout.fullNameLabelTopAnchor),
			fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												   constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupFullNameTextField() {
		self.addSubview(fullNameTextField)
		fullNameTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor,
												   constant: Layout.textFieldTopAnchor),
			fullNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													   constant: Layout.leadingAndTrailingAnchor),
			fullNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														constant: -Layout.leadingAndTrailingAnchor)
		])
	}

	func setupAboutLabel() {
		self.addSubview(aboutLabel)
		aboutLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor,
											constant: Layout.aboutLabelTopAnchor),
			aboutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupAboutTextField() {
		self.addSubview(aboutTextField)
		aboutTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutTextField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,
												constant: Layout.textFieldTopAnchor),
			aboutTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor,
													constant: Layout.leadingAndTrailingAnchor),
			aboutTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor,
													 constant: -Layout.leadingAndTrailingAnchor)
		])
	}

	func setupSexLabel() {
		self.addSubview(sexLabel)
		sexLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sexLabel.topAnchor.constraint(equalTo: aboutTextField.bottomAnchor,
										  constant: Layout.sexLabelTopAnchor),
			sexLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
											  constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupSexSegmentedControl() {
		self.addSubview(sexSegmentedControl)
		sexSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sexSegmentedControl.topAnchor.constraint(equalTo: sexLabel.bottomAnchor,
													 constant: Layout.sexSegmentTopAnchor),
			sexSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor,
														 constant: Layout.leadingAndTrailingAnchor),
			sexSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor,
														  constant: -Layout.leadingAndTrailingAnchor),
			sexSegmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}

	func setupComeinButton() {
		self.addSubview(comeinButton)
		comeinButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			comeinButton.topAnchor.constraint(equalTo: sexSegmentedControl.bottomAnchor,
											  constant: Layout.comeInButtonTopAnchor),
			comeinButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
												  constant: Layout.leadingAndTrailingAnchor),
			comeinButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
												   constant: -Layout.leadingAndTrailingAnchor)

		])
	}
}

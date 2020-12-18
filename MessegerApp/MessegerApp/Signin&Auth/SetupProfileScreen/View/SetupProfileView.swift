//
//  SetupProfileView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit
import FirebaseAuth

final class SetupProfileView: UIView {

	private let fillImageView = AddPhotoView()

	private let profileLabel = UILabel(text: "Set up profile", font: .avenirTitle())
	private let fullNameLabel = UILabel(text: "Full name")
	private let aboutLabel = UILabel(text: "About me")
	private let sexLabel = UILabel(text: "Sex")
	 let fullNameTextField = OneLineTextField(font: .avenirDefault())
	 let aboutTextField = OneLineTextField(font: .avenirDefault())
	 let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
	 let comeinButton = UIButton(title: "To come in",
										titleColor: .white,
										backgroundColor: .buttonBlack(),
										font: .avenirDefault(),
										isShadow: false,
										cornerRadius: 4)

	//private let alertControl = AlertControl()

//	private let currentUser: User
//	init(currentUser: User) {
//		self.currentUser = currentUser
//
//
//	}

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white



		setupViewLayout()
		//setupActionButton()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}

//private extension SetupProfileView {
//	func setupActionButton() {
//		comeinButton.addTarget(self, action: #selector(comeinButtonTapped), for: .touchUpInside)
//	}
////&&
//	@objc func comeinButtonTapped() {
//		guard let email = currentUser.email else {return}
//
//		FirestoreService.shared.saveProfileWith(
//			id: currentUser.uid,
//			email: email,
//			username: fullNameTextField.text,
//			avataImageString: "nil",
//			description: aboutTextField.text,
//			sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { (result) in
//
//			switch result {
//
//			case .success(let user):
//				self.alertControl.showAllertController(title: "Sucess!", message: "Приятного общения!")
//				print(user)
//			case .failure(let error):
//				self.alertControl.showAllertController(title: "Error!", message: error.localizedDescription)
//			}
//		}
//	}
//}

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
			profileLabel.topAnchor.constraint(equalTo: self.topAnchor,
											constant: 100),
			profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor )
			])
		}

	func setupFillImageView() {
		self.addSubview(fillImageView)
		fillImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fillImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,
											constant: 30),
			fillImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor )
			])
	}

	func setupFullNameLabel() {
		self.addSubview(fullNameLabel)
		fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fullNameLabel.topAnchor.constraint(equalTo: fillImageView.bottomAnchor, constant: 30),
			fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupFullNameTextField() {
		self.addSubview(fullNameTextField)
		fullNameTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
			fullNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			fullNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
		])
	}

	func setupAboutLabel() {
		self.addSubview(aboutLabel)
		aboutLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 30),
			aboutLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupAboutTextField() {
		self.addSubview(aboutTextField)
		aboutTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutTextField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 20),
			aboutTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			aboutTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40)
		])
	}

	func setupSexLabel() {
		self.addSubview(sexLabel)
		sexLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sexLabel.topAnchor.constraint(equalTo: aboutTextField.bottomAnchor, constant: 20),
			sexLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
		])
	}

	func setupSexSegmentedControl() {
		self.addSubview(sexSegmentedControl)
		sexSegmentedControl.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			sexSegmentedControl.topAnchor.constraint(equalTo: sexLabel.bottomAnchor, constant: 20),
			sexSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			sexSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
			sexSegmentedControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
	}

	func setupComeinButton() {
		self.addSubview(comeinButton)
		comeinButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			comeinButton.topAnchor.constraint(equalTo: sexSegmentedControl.bottomAnchor, constant: 50),
			comeinButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
			comeinButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)

		])
	}
}

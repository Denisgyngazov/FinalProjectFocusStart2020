//
//  ProfileView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 20.12.2020.
//

import UIKit

final class ProfileView: UIView {

	//MARK: - View

	private let containerView = UIView()
	 let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"), contentMode: .scaleAspectFill)
	 let nameLabel = UILabel(text: "", font: .systemFont(ofSize: 28, weight: .light))
	 let aboutLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .light))
	 let myTextFIeld = InsertableTextField()

	//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewApperance()
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

	//MARK: - Setup Apperance

private extension ProfileView {
	func setupViewApperance() {
		setupContainerViewApperance()
		setupAboutLabelApperance()
	}

	func setupContainerViewApperance() {
		containerView.backgroundColor = .mainWhite()
		containerView.layer.cornerRadius = 30
	}

	func setupAboutLabelApperance() {
		aboutLabel.numberOfLines = 0
	}
}

//MARK: - Layout

private extension ProfileView {
	func setupViewLayout() {
		setupContainerView()
		setupImageView()
		setupNameLabel()
		setupAboutLabel()
		setupTextField()
	}

	func setupContainerView() {
		self.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			containerView.heightAnchor.constraint(equalToConstant: 205)
		])
	}

	func setupImageView() {
		self.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: self.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)
		])
	}

	func setupNameLabel() {
		containerView.addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
			nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
		])

	}

	func setupAboutLabel() {
		containerView.addSubview(aboutLabel)
		aboutLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
			aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
		])
	}

	func setupTextField() {
		containerView.addSubview(myTextFIeld)
		myTextFIeld.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			myTextFIeld.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
			myTextFIeld.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			myTextFIeld.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
			myTextFIeld.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}

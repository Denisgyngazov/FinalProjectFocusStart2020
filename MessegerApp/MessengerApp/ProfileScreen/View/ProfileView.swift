//
//  ProfileView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 20.12.2020.
//

import UIKit

final class ProfileView: UIView {

	//MARK: - Property

	private enum Metrics {
		static let imageView: UIImage = #imageLiteral(resourceName: "avatar")
		static let nameLabelText: String = ""
		static let aboutLabelText: String = ""
	}

	private enum Layout {
		static let conteinerViewCornerRadius: CGFloat = 30
		static let aboutLabelNumberOfLines: Int = 0
		static let containerViewHeight: CGFloat = 205
		static let imageViewBottomAnchor: CGFloat = 30
		static let leadingAndTrailingAnchor: CGFloat = 25
		static let nameLabelTopAnchor: CGFloat = 50
		static let aboutLabelTopAnchor: CGFloat = 8
		static let textFieldTopAnchor: CGFloat = 8
		static let textFieldHeight: CGFloat = 50
	}

	//MARK: - View

	private let containerView = UIView()
	let imageView = UIImageView(image: Metrics.imageView,
								contentMode: .scaleAspectFill)
	let nameLabel = UILabel(text: Metrics.nameLabelText,
							font: .systemFont(ofSize: 28, weight: .light))
	let aboutLabel = UILabel(text: Metrics.aboutLabelText,
							 font: .systemFont(ofSize: 16, weight: .light))
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
		containerView.layer.cornerRadius = Layout.conteinerViewCornerRadius
	}

	func setupAboutLabelApperance() {
		aboutLabel.numberOfLines = Layout.aboutLabelNumberOfLines
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
			containerView.heightAnchor.constraint(equalToConstant: Layout.containerViewHeight)
		])
	}

	func setupImageView() {
		self.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: self.topAnchor),
			imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			imageView.bottomAnchor.constraint(equalTo: containerView.topAnchor,
											  constant: Layout.imageViewBottomAnchor)
		])
	}

	func setupNameLabel() {
		containerView.addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
										   constant: Layout.nameLabelTopAnchor),
			nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
											   constant: Layout.leadingAndTrailingAnchor),
			nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
												constant: -Layout.leadingAndTrailingAnchor)
		])

	}

	func setupAboutLabel() {
		containerView.addSubview(aboutLabel)
		aboutLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
											constant: Layout.aboutLabelTopAnchor),
			aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
												constant: Layout.leadingAndTrailingAnchor),
			aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
												 constant: -Layout.leadingAndTrailingAnchor)
		])
	}

	func setupTextField() {
		containerView.addSubview(myTextFIeld)
		myTextFIeld.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			myTextFIeld.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,
											 constant: Layout.textFieldTopAnchor),
			myTextFIeld.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
												 constant: Layout.leadingAndTrailingAnchor),
			myTextFIeld.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
												  constant: -Layout.leadingAndTrailingAnchor),
			myTextFIeld.heightAnchor.constraint(equalToConstant: Layout.textFieldHeight)
		])
	}
}

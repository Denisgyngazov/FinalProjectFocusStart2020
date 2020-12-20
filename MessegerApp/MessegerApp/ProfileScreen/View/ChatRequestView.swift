//
//  ChatRequestView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 20.12.2020.
//

import UIKit

final class ChatRequestView: UIView {

	//MARK: - Property

	private enum Metrics {
		static let cancelTitle: String = "Cancel"
		static let cancelTitleColor: UIColor = .buttonRed()
		static let cancelFont: UIFont? = .avenirDefault()
		static let cancelBackgroundColor: UIColor = .mainWhite()
		static let cancelIsShadow: Bool = false
		static let cancelCornerRadius: CGFloat = 10

		static let aceptTitle: String = "Acept"
		static let aceptFont: UIFont? = .avenirDefault()
		static let aceptTitleColor: UIColor = .mainWhite()
		static let aceptBackgroundColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
		static let aceptIsShadow: Bool = false
		static let aceptCornerRadius: CGFloat = 10
	}
	
	//MARK: - View

	private let containerView = UIView()
	 let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"), contentMode: .scaleAspectFill)
	 let nameLabel = UILabel(text: "", font: .systemFont(ofSize: 28, weight: .light))
	private let aboutLabel = UILabel(text: "", font: .systemFont(ofSize: 16, weight: .light))
	 let cancelButton = UIButton(title: Metrics.cancelTitle,
								   titleColor: Metrics.cancelTitleColor,
								   backgroundColor: Metrics.cancelBackgroundColor,
								   font: Metrics.cancelFont,
								   isShadow: Metrics.cancelIsShadow,
								   cornerRadius: Metrics.cancelCornerRadius)

	 let acceptButton = UIButton(title: Metrics.aceptTitle,
								   titleColor: Metrics.aceptTitleColor,
								   backgroundColor: Metrics.aceptBackgroundColor,
								   font: Metrics.aceptFont,
								   isShadow: Metrics.aceptIsShadow,
								   cornerRadius: Metrics.aceptCornerRadius)

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
	//MARK: - Apperance

private extension ChatRequestView {
	func setupViewApperance() {
		setupContainerViewApperance()
		setupAboutLabelApperance()
		setupCancelButtonApperance()
	}

	func setupContainerViewApperance() {
		containerView.backgroundColor = .mainWhite()
		containerView.layer.cornerRadius = 30
	}

	func setupAboutLabelApperance() {
		aboutLabel.numberOfLines = 0
	}

	func setupCancelButtonApperance() {
		cancelButton.layer.borderWidth = 1.2
		cancelButton.layer.borderColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
	}
}

//MARK: - Layout

private extension ChatRequestView {
	func setupViewLayout() {
		setupContainerView()
		setupImageView()
		setupNameLabel()
		setupAboutLabel()
		setupCancelButton()
		setupAcceptButton()
	}

	func setupContainerView() {
		self.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
			nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
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

	func setupCancelButton() {
		containerView.addSubview(cancelButton)
		cancelButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
			cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
			cancelButton.widthAnchor.constraint(equalToConstant: 150),
		])
	}

	func setupAcceptButton() {
		containerView.addSubview(acceptButton)
		acceptButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			acceptButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 120),
			acceptButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			acceptButton.widthAnchor.constraint(equalToConstant: 150)
		])
	}
}

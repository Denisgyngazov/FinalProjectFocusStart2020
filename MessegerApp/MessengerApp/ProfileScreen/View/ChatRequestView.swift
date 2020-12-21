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
		static let imageView: UIImage = #imageLiteral(resourceName: "avatar")
		static let nameLabelText: String = ""
		static let aboutLabelText: String = "Wants to start a dialogue with you"

		static let cancelTitle: String = "Cancel"
		static let cancelTitleColor: UIColor = .buttonRed()
		static let cancelFont: UIFont? = .avenirDefault()
		static let cancelBackgroundColor: UIColor = .mainWhite()
		static let cancelIsShadow: Bool = false
		static let cancelCornerRadius: CGFloat = 10

		static let aceptTitle: String = "Accept"
		static let aceptFont: UIFont? = .avenirDefault()
		static let aceptTitleColor: UIColor = .mainWhite()
		static let aceptBackgroundColor: UIColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
		static let aceptIsShadow: Bool = false
		static let aceptCornerRadius: CGFloat = 10

		static let cancelButtonBorderWidth: CGFloat = 1.2
		static let cancelButtonBorderColor: CGColor = #colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1)
	}

	private enum Layout {
		static let conteinerViewCornerRadius: CGFloat = 30
		static let aboutLabelNumberOfLines: Int = 0
		static let containerViewHeight: CGFloat = 205
		static let imageViewBottomAnchor: CGFloat = 30
		static let leadingAndTrailingAnchor: CGFloat = 25
		static let nameLabelTopAnchor: CGFloat = 35
		static let aboutLabelTopAnchor: CGFloat = 8
		static let cancelAndAcceptButtonTopAnchor: CGFloat = 120
		static let cancelAndAcceptButtonWidth: CGFloat = 150
	}

	//MARK: - View

	private let containerView = UIView()
	let imageView = UIImageView(image: Metrics.imageView,
								contentMode: .scaleAspectFill)
	let nameLabel = UILabel(text: Metrics.nameLabelText,
							font: .systemFont(ofSize: 28, weight: .light))
	private let aboutLabel = UILabel(text: Metrics.aboutLabelText,
									 font: .systemFont(ofSize: 16, weight: .light))
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
		containerView.layer.cornerRadius = Layout.conteinerViewCornerRadius
	}

	func setupAboutLabelApperance() {
		aboutLabel.numberOfLines = Layout.aboutLabelNumberOfLines
	}

	func setupCancelButtonApperance() {
		cancelButton.layer.borderWidth = Metrics.cancelButtonBorderWidth
		cancelButton.layer.borderColor = Metrics.cancelButtonBorderColor
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

	func setupCancelButton() {
		containerView.addSubview(cancelButton)
		cancelButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			cancelButton.topAnchor.constraint(equalTo: containerView.topAnchor,
											  constant: Layout.cancelAndAcceptButtonTopAnchor),
			cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
												   constant: -Layout.leadingAndTrailingAnchor),
			cancelButton.widthAnchor.constraint(equalToConstant: Layout.cancelAndAcceptButtonWidth),
		])
	}

	func setupAcceptButton() {
		containerView.addSubview(acceptButton)
		acceptButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			acceptButton.topAnchor.constraint(equalTo: containerView.topAnchor,
											  constant: Layout.cancelAndAcceptButtonTopAnchor),
			acceptButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
												  constant: Layout.leadingAndTrailingAnchor),
			acceptButton.widthAnchor.constraint(equalToConstant: Layout.cancelAndAcceptButtonWidth)
		])
	}
}

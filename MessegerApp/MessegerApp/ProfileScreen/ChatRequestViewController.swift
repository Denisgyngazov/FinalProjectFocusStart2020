//
//  ChatRequestViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit

final class ChatRequestViewController: UIViewController {

	private let containerView = UIView()
	private let imageVIew = UIImageView(image: #imageLiteral(resourceName: "avatar"), contentMode: .scaleAspectFill)
	private let nameLabel = UILabel(text: "Peter", font: .systemFont(ofSize: 28, weight: .light))
	private let aboutLabel = UILabel(text: "Yoy hahe the opportunity to start a new chat", font: .systemFont(ofSize: 16, weight: .light))
	private let cancelButton = UIButton(title: Metrics.cancelTitle,
								   titleColor: Metrics.cancelTitleColor,
								   backgroundColor: Metrics.cancelBackgroundColor,
								   font: Metrics.cancelFont,
								   isShadow: Metrics.cancelIsShadow,
								   cornerRadius: Metrics.cancelCornerRadius)

	private let acceptButton = UIButton(title: Metrics.aceptTitle,
								   titleColor: Metrics.aceptTitleColor,
								   backgroundColor: Metrics.aceptBackgroundColor,
								   font: Metrics.aceptFont,
								   isShadow: Metrics.aceptIsShadow,
								   cornerRadius: Metrics.aceptCornerRadius)

	private var chat: Message
	weak var delegate: WaitingChatDelegate?

	private enum Metrics {

//MARK: - Button propertys

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

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
		setupViewApperance()
		setupViewLayout()
		setupActionButton()
	}

	init(chat: Message) {
		self.chat = chat
		nameLabel.text = chat.friendUsername
		imageVIew.sd_setImage(with: URL(string: chat.friendUserImageString), completed: nil)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
//MARK: - Setup action button

private extension ChatRequestViewController {
	func setupActionButton() {
		cancelButton.addTarget(self, action: #selector(setupCancelTapped), for: .touchUpInside)
		acceptButton.addTarget(self, action: #selector(setupActionTapped), for: .touchUpInside)

	}

	@objc func setupCancelTapped() {
		self.dismiss(animated: true) {
			self.delegate?.removeWaitingChat(chat: self.chat)
		}
	}
	@objc func setupActionTapped() {
		self.dismiss(animated: true) {
			self.delegate?.chatToActive(chat: self.chat)
		}
	}
}

private extension ChatRequestViewController {
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


private extension ChatRequestViewController {
	func setupViewLayout() {
		setupContainerView()
		setupImageView()
		setupNameLabel()
		setupAboutLabel()
		setupCancelButton()
		setupAcceptButton()

	}

	func setupContainerView() {
		view.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.heightAnchor.constraint(equalToConstant: 205)
		])

	}

	func setupImageView() {
		view.addSubview(imageVIew)
		imageVIew.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageVIew.topAnchor.constraint(equalTo: view.topAnchor),
			imageVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageVIew.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)

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

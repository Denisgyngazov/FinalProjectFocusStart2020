//
//  ActiveChatCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class ActiveChatCell: UICollectionViewCell {


	private let friendImageView = UIImageView()
	private let friendName = UILabel(text: "User", font: .laoSangam20())
	private let lastMessage = UILabel(text: "How are you?", font: .laoSangam18())
	private let gradientView = GradientView(from: .topTrailing, to: .bottomTrailing, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.backgroundColor = .white
		setupCellApperance()
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension ActiveChatCell: ConfigureCell {
	func configure<U>(with value: U) where U : Hashable {
		guard let message: Message = value as? Message else { return }
		friendImageView.sd_setImage(with: URL(string: message.friendUserImageString), completed: nil)
		friendName.text = message.friendUsername
		lastMessage.text = message.lastMessage
	}

	static var identifaer = String(describing: self)

}

private extension ActiveChatCell {
	func setupCellApperance() {
		self.layer.cornerRadius = 4
		self.clipsToBounds = true
	}
}

private extension ActiveChatCell {
	func setupViewLayout() {
		setupFriendImageView()
		setupGradiendView()
		setupFreindName()
		setupLastImageView()

	}

	func setupFriendImageView() {
		self.addSubview(friendImageView)
		friendImageView.translatesAutoresizingMaskIntoConstraints = false
		friendImageView.backgroundColor = .white

		NSLayoutConstraint.activate([
			friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			friendImageView.heightAnchor.constraint(equalToConstant: 74),
			friendImageView.widthAnchor.constraint(equalToConstant: 74)

		])
	}

	func setupGradiendView() {
		self.addSubview(gradientView)
		gradientView.translatesAutoresizingMaskIntoConstraints = false
		gradientView.backgroundColor = .black
		NSLayoutConstraint.activate([
			gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			gradientView.heightAnchor.constraint(equalToConstant: 74),
			gradientView.widthAnchor.constraint(equalToConstant: 8)
		])

	}

	func setupFreindName() {
		self.addSubview(friendName)
		friendName.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			friendName.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
			friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
			friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
		])
	}

	func setupLastImageView() {
		self.addSubview(lastMessage)
		lastMessage.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
			lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
			lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16)
		])
	}
}

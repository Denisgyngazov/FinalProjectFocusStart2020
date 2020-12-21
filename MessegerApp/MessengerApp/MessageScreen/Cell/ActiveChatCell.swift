//
//  ActiveChatCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class ActiveChatCell: UICollectionViewCell {

	//MARK: - Property

	private enum Metrics {
		static let cellCornerRadius: CGFloat = 4
		static let cellClipsToBounds: Bool = true
		static let friendName: String = ""
		static let lastMessage: String = ""
	}

	private enum Layout {
		static let friendImageViewWidth: CGFloat = 74
		static let friendImageViewHeight: CGFloat = 74
		static let gradientViewHeight: CGFloat = 74
		static let gradientViewWidth: CGFloat = 8
		static let topAndBottomAnchor: CGFloat = 12
		static let leadingAndTrailingAnchor: CGFloat = 16

	}

	private let friendImageView = UIImageView()
	private let friendName = UILabel(text: Metrics.friendName,
									 font: .laoSangam20())
	private let lastMessage = UILabel(text: Metrics.lastMessage,
									  font: .laoSangam18())
	private let gradientView = GradientView(from: .topTrailing,
											to: .bottomTrailing,
											startColor: .startColorGradient(),
											endColor: .endColorGradient())

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

	static var identifaer = String(describing: self)

	func configure<U>(with value: U) where U : Hashable {
		guard let message: Message = value as? Message else { return }
		friendImageView.sd_setImage(with: URL(string: message.friendUserImageString), completed: nil)
		friendName.text = message.friendUsername
		lastMessage.text = message.lastMessage
	}
}

private extension ActiveChatCell {
	func setupCellApperance() {
		self.layer.cornerRadius = Metrics.cellCornerRadius
		self.clipsToBounds = Metrics.cellClipsToBounds
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

		NSLayoutConstraint.activate([
			friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			friendImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			friendImageView.heightAnchor.constraint(equalToConstant: Layout.friendImageViewHeight),
			friendImageView.widthAnchor.constraint(equalToConstant: Layout.friendImageViewWidth)
		])
	}

	func setupGradiendView() {
		self.addSubview(gradientView)
		gradientView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			gradientView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			gradientView.heightAnchor.constraint(equalToConstant: Layout.gradientViewHeight),
			gradientView.widthAnchor.constraint(equalToConstant: Layout.gradientViewWidth)
		])
	}

	func setupFreindName() {
		self.addSubview(friendName)
		friendName.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			friendName.topAnchor.constraint(equalTo: self.topAnchor,
											constant: Layout.topAndBottomAnchor),
			friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor,
												constant: Layout.leadingAndTrailingAnchor),
			friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor,
												 constant: Layout.leadingAndTrailingAnchor)
		])
	}

	func setupLastImageView() {
		self.addSubview(lastMessage)
		lastMessage.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			lastMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor,
												constant: -Layout.topAndBottomAnchor),
			lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor,
												 constant: Layout.leadingAndTrailingAnchor),
			lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor,
												  constant: Layout.leadingAndTrailingAnchor)
		])
	}
}

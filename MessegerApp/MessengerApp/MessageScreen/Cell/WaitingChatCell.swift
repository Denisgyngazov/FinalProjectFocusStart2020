//
//  WaitingChatCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class WaitingChatCell: UICollectionViewCell {

	//MARK: - Property

	private enum Metrics {
		static let idenfifaer: String = "WaitingChatCell"
		static let cellCornerRadius: CGFloat = 4
		static let cellClipsToBounds: Bool = true
	}

	//MARK: - View

	private let friendImageView = UIImageView()

	//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupCellApperance()
		setupViewLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
	//MARK: - Configure cell

extension WaitingChatCell: ConfigureCell {
	static var identifaer = Metrics.idenfifaer

	func configure<U>(with value: U) where U : Hashable {
		guard let message: Message = value as? Message else { return }
		friendImageView.sd_setImage(with: URL(string: message.friendUserImageString), completed: nil)
	}
}

	//MARK: - Apperance

private extension WaitingChatCell {
	func setupCellApperance() {
		self.layer.cornerRadius = Metrics.cellCornerRadius
		self.clipsToBounds = Metrics.cellClipsToBounds
	}
}
	//MARK: - Layout
private extension WaitingChatCell {
	func setupViewLayout() {
		setupFriendImageView()
	}

	func setupFriendImageView() {
		self.addSubview(friendImageView)
		friendImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
			friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}

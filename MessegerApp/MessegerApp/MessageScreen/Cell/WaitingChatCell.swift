//
//  WaitingChatCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class WaitingChatCell: UICollectionViewCell {

	private let friendImageView = UIImageView()


	override init(frame: CGRect) {
		super.init(frame: frame)

		setupCellApperance()
		setupViewLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension WaitingChatCell: ConfigureCell {
	func configure<U>(with value: U) where U : Hashable {
		guard let message: Message = value as? Message else { return }
		friendImageView.image = UIImage(named: message.userImageString)
	}

	static var identifaer = "WaitingChatCell"

}

private extension WaitingChatCell {
	func setupCellApperance() {
		self.layer.cornerRadius = 4
		self.clipsToBounds = true
	}
}

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

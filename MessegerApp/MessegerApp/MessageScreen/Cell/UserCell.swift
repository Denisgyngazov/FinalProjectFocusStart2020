//
//  UserCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class UserCell: UICollectionViewCell {

	private let userImageView = UIImageView()
	private let userName = UILabel(text: "textgfdgdfgdfgdfgdfgdfgd", font: .laoSangam20())
	private let view = UIView()

	override init(frame: CGRect ) {
		super.init(frame: frame)
		backgroundColor = .white
		setupViewCell()
		setupViewLayout()
	}



	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension UserCell {
	override func layoutSubviews() {
		super.layoutSubviews()
		self.view.layer.cornerRadius = 15
		self.view.clipsToBounds = true
	}
}

extension UserCell: ConfigureCell {
	func configure<U>(with value: U) where U : Hashable {
		guard let user: User = value as? User else { return }
		userImageView.image = UIImage(named: user.avatarStringURL)
		userName.text = user.username
	}

	static var identifaer = String(describing: self)
}

private extension UserCell {
	func setupViewCell() {
		setupShadowCell()
	}

	func setupShadowCell() {
		self.layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
		self.layer.shadowRadius = 4
		self.layer.shadowOpacity = 0.5
		self.layer.shadowOffset = CGSize(width: 0, height: 4)
	}
}

private extension UserCell {
	func setupViewLayout() {
		setupView()
		setupUserImageView()
		setupUserName()
	}

	func setupView() {
		self.addSubview(view)
		view.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: self.topAnchor),
			view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			view.bottomAnchor.constraint(equalTo: self.bottomAnchor)

		])
	}

	func setupUserImageView() {
		view.addSubview(userImageView)
		userImageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userImageView.topAnchor.constraint(equalTo: view.topAnchor),
			userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			userImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			userImageView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -40)


		])

	}

	func setupUserName() {
		view.addSubview(userName)
		userName.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userName.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
			userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
			userName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
			userName.bottomAnchor.constraint(equalTo: view.bottomAnchor)

		])
	}

}

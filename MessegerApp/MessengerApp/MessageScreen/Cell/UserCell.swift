//
//  UserCell.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit
import SDWebImage

final class UserCell: UICollectionViewCell {

	//MARK: - Property

	private enum Metrics {
		static let shadowColorCell: CGColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
		static let shadowRadiusCell: CGFloat = 4
		static let shadowOpacityCell: Float = 0.5
		static let shadowOffSetWidth: Int = 0
		static let shadowOffSetHeight: Int = 4

		static let cornerRadiusLayoutSubview: CGFloat = 15
		static let clipsToBoundsLayoutSubview: Bool = true

		static let userNameText: String = ""

	}

	private enum Layout {
		static let userImageViewHeight: CGFloat = 40
		static let userNameLeadingAndTrailing: CGFloat = 8
	}

	//MARK: - View

	private let userImageView = UIImageView()
	private let userName = UILabel(text: Metrics.userNameText,
								   font: .laoSangam20())
	private let view = UIView()

	//MARK: - Init

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
	//MARK: - Ovveride layoutSubviews

extension UserCell {
	override func layoutSubviews() {
		super.layoutSubviews()
		self.view.layer.cornerRadius = Metrics.cornerRadiusLayoutSubview
		self.view.clipsToBounds = Metrics.clipsToBoundsLayoutSubview
	}

	override func prepareForReuse() {
		userImageView.image = nil
	}
}

	//MARK: - Cell configure

extension UserCell: ConfigureCell {

	static var identifaer = String(describing: self)

	func configure<U>(with value: U) where U : Hashable {
		guard let user: MUser = value as? MUser else { return }
		userName.text = user.username
		guard let url = URL(string: user.avatarStringURL) else { return }
		userImageView.sd_setImage(with: url, completed: nil)
	}
}

	//MARK: - Setup View cell

private extension UserCell {
	func setupViewCell() {
		setupShadowCell()
	}

	func setupShadowCell() {
		self.layer.shadowColor = Metrics.shadowColorCell
		self.layer.shadowRadius = Metrics.shadowRadiusCell
		self.layer.shadowOpacity = Metrics.shadowOpacityCell
		self.layer.shadowOffset = CGSize(width: Metrics.shadowOffSetWidth,
										 height: Metrics.shadowOffSetHeight)
	}
}

	//MARK: - Layout

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
			userImageView.heightAnchor.constraint(equalTo: view.widthAnchor,
												  constant: -Layout.userImageViewHeight)
		])
	}

	func setupUserName() {
		view.addSubview(userName)
		userName.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userName.topAnchor.constraint(equalTo: userImageView.bottomAnchor),
			userName.leadingAnchor.constraint(equalTo: view.leadingAnchor,
											  constant: Layout.userNameLeadingAndTrailing),
			userName.trailingAnchor.constraint(equalTo: view.trailingAnchor,
											   constant: -Layout.userNameLeadingAndTrailing),
			userName.bottomAnchor.constraint(equalTo: view.bottomAnchor)

		])
	}
}

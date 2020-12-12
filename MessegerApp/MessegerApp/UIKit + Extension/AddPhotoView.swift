//
//  AddPhotoView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class AddPhotoView: UIView {

	private let imageView = UIImageView()
	private let plusButton = UIButton(type: .system)

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewApperance()
		setupViewLayout()
		layoutSubviews()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		imageView.layer.masksToBounds = true
		imageView.layer.cornerRadius = imageView.frame.width / 2
	}

}

private extension AddPhotoView {
	func setupViewApperance() {
		setupImageViewApperance()
		setupPlusViewApperance()
	}

	func setupImageViewApperance() {
		imageView.image = #imageLiteral(resourceName: "avatar")
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
		imageView.layer.borderColor = UIColor.black.cgColor
		imageView.layer.borderWidth = 1

	}

	func setupPlusViewApperance() {
		plusButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
		plusButton.tintColor = .buttonBlack()

	}
}

private extension AddPhotoView {
	func setupViewLayout() {
		setupimageView()
		setupPlusButton()
		setupViewConstraints()
	}

	func setupimageView() {
		self.addSubview(imageView)
		imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
			imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
			imageView.widthAnchor.constraint(equalToConstant: 100),
			imageView.heightAnchor.constraint(equalToConstant: 100)
			
		])

	}

	func setupPlusButton() {
		self.addSubview(plusButton)
		plusButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			plusButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
			plusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			plusButton.widthAnchor.constraint(equalToConstant: 30),
			plusButton.heightAnchor.constraint(equalToConstant: 30),

		])
	}

	func setupViewConstraints() {
		NSLayoutConstraint.activate([
			self.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
			self.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor)
		])
	}
}

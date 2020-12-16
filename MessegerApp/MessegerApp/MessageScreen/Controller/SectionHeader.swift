//
//  SectionHeader.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class SectionHeader: UICollectionReusableView {

	static let reuseIdentifaer = String(describing: self)

	private let headerTitle = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension SectionHeader {
	func configure(text: String , font: UIFont? , textColor: UIColor) {
		headerTitle.text = text
		headerTitle.font = font
		headerTitle.textColor = textColor
		
	}
}

private extension SectionHeader {
	func setupViewLayout() {
		setupHeaderTitle()

	}

	func setupHeaderTitle() {
		self.addSubview(headerTitle)
		headerTitle.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			headerTitle.topAnchor.constraint(equalTo: self.topAnchor),
			headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor)
		])
	}
}

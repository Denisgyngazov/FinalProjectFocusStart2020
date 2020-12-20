//
//  SectionHeader.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class SectionHeader: UICollectionReusableView {
	//MARK: - Property

	static let reuseIdentifaer = String(describing: self)
	
	//MARK: - View

	private let headerTitle = UILabel()

	//MARK: - Init

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewLayout()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
	//MARK: - Configure

extension SectionHeader {
	func configure(text: String , font: UIFont? , textColor: UIColor) {
		headerTitle.text = text
		headerTitle.font = font
		headerTitle.textColor = textColor
	}
}
	//MARK: - Layout

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

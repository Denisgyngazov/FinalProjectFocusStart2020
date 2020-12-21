//
//  UITextField + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class OneLineTextField: UITextField {

	private var bottomView = UIView()

	convenience init(font: UIFont? = .avenirDefault()) {
		self.init()

		self.font = font
		self.borderStyle = .none
		self.translatesAutoresizingMaskIntoConstraints = false

		setupViewApperance()
		setupViewLayout()

	}
}

private extension OneLineTextField {
	func setupViewApperance() {
		bottomView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
		bottomView.backgroundColor = .textFieldLight()
	}
}

private extension OneLineTextField {
	func setupViewLayout() {
		self.addSubview(bottomView)
		bottomView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
		bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
		bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
		bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
		bottomView.heightAnchor.constraint(equalToConstant: 1)
		])
	}
}




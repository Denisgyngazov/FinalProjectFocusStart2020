//
//  InsertableTextField.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit

final class InsertableTextField: UITextField {

	private let image = UIImage(systemName: "smiley")
	private var imageView = UIImageView()
	private var button = UIButton(type: .system)


	override init(frame: CGRect) {
		super.init(frame: frame)
		setupViewApperance()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Layout

extension InsertableTextField {
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.leftViewRect(forBounds: bounds)
		rect.origin.x += 12
		return rect
	}

	override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
		var rect = super.rightViewRect(forBounds: bounds)
		rect.origin.x += -12
		return rect
	}

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 36, dy: 0)
	}

	override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 36, dy: 0)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return bounds.insetBy(dx: 36, dy: 0)
	}
}


//MARK: - Apperance

private extension InsertableTextField {
	func setupViewApperance() {
		setupViewTextField()
		setupImageViewApperance()
		setupButtonApperance()
	}

	func setupViewTextField() {
		self.backgroundColor = .white
		self.placeholder = "White"
		self.font = UIFont.systemFont(ofSize: 14)
		self.borderStyle = .none
		self.clearButtonMode = .whileEditing
		self.layer.cornerRadius = 18
		self.layer.masksToBounds = true

	}

	func setupImageViewApperance() {
		imageView = UIImageView(image: image)
		self.leftView = imageView
		self.leftView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
		self.leftViewMode = .always
	}

	func setupButtonApperance() {
		button.setImage(UIImage(named: "Sent"), for: .normal)
		//button.applyGradients(cornerRadius: 10)
		self.rightView = button
		self.rightView?.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
		self.rightViewMode = .always

	}
}


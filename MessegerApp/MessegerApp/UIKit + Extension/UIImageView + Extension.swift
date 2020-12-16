//
//  UIImageView + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

extension UIImageView {

	convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
	self.init()

		self.image = image
		self.contentMode = contentMode
	}

}

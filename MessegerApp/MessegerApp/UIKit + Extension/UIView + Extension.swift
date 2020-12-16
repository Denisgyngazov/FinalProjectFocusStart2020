//
//  UIView + Extension.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

//import UIKit
//
//extension UIView {
//	func applyGradients(cornerRadius: CGFloat) {
//		self.backgroundColor = nil
//		self.layoutIfNeeded()
//		let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), endColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
//
//		if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
//			gradientLayer.frame = self.bounds
//			gradientLayer.cornerRadius = cornerRadius
//
//		}
//
//		self.layer.insertSublayer(gradientView, at: 0)
//	}
//	
//}

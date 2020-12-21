//
//  GradientView.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

final class GradientView: UIView {

	private let gradientLayer = CAGradientLayer()

	 private var startColor: UIColor? {
		didSet {
			setupGradientColors(startColor: startColor, endColor: endColor)
		}
	}

	 private var endColor: UIColor? {
		didSet {
			setupGradientColors(startColor: startColor, endColor: endColor)
		}
	}

	 enum Point {
		case topLeading
		case leading
		case bottomLeading
		case top
		case center
		case bottom
		case topTrailing
		case trailing
		case bottomTrailing

		var point: CGPoint {
			switch self {

			case .topLeading:
				return CGPoint(x: 0, y: 0)
			case .leading:
				return CGPoint(x: 0, y: 0.5)
			case .bottomLeading:
				return CGPoint(x: 0, y: 1.0)
			case .top:
				return CGPoint(x: 0.5, y: 0)
			case .center:
				return CGPoint(x: 0.5, y: 0.5)
			case .bottom:
				return CGPoint(x: 0.5, y: 1.0)
			case .topTrailing:
				return CGPoint(x: 1.0, y: 0.0)
			case .trailing:
				return CGPoint(x: 1.0, y: 0.5)
			case .bottomTrailing:
				return CGPoint(x: 1.0, y: 1.0)
			}
	   }
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

	}

	init(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
		self.init()
		setupGradient(from: from, to: to, startColor: startColor, endColor: endColor)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupGradient(from: .leading, to: .trailing, startColor: startColor, endColor: endColor)
	}
}

extension GradientView {
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
}

private extension GradientView {
	func setupGradient(from: Point, to: Point, startColor: UIColor?, endColor: UIColor?) {
		self.layer.addSublayer(gradientLayer)
		setupGradientColors(startColor: startColor, endColor: endColor)
		gradientLayer.startPoint = from.point
		gradientLayer.endPoint = to.point

	}
}

private extension GradientView {
	func setupGradientColors(startColor: UIColor?, endColor: UIColor?) {
		if let startColor = startColor, let endColor = endColor {
			gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		}
	}
}

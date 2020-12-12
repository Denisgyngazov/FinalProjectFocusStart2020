//
//  SignUpViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SignUpViewController: UIViewController {

	private let singUpView = SingUpView()

	override func loadView() {
		self.view = singUpView
	}
}


import SwiftUI

struct SignViewControllerProvide: PreviewProvider {
	static var previews: some View {

		ContainerView().edgesIgnoringSafeArea(.all)
	}
}

struct ContainerView: UIViewControllerRepresentable {

	let viewController = SignUpViewController()

	func makeUIViewController(context: Context) -> some UIViewController {
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

	}


}

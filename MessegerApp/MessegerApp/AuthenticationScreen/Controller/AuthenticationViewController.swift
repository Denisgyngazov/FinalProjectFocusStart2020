//
//  ViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 11.12.2020.
//

import UIKit

class AuthenticationViewController: UIViewController {

	private let authenticationView = AuthenticationView()

	override func loadView() {
		self.view = authenticationView

	}
}







import SwiftUI

struct ViewControllerProvide: PreviewProvider {
	static var previews: some View {
		ContainerVieww().edgesIgnoringSafeArea(.all)
	}
}

struct ContainerVieww: UIViewControllerRepresentable {

	let viewController = AuthenticationViewController()

	func makeUIViewController(context: Context) -> some UIViewController {
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

	}


}

//
//  LoginViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class LoginViewController: UIViewController {
	private let loginView = LoginView()

	override func loadView() {
		self.view = loginView

	}
}

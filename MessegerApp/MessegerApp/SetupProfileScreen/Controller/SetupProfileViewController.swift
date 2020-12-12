//
//  SetupProfileViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 12.12.2020.
//

import UIKit

final class SetupProfileViewController: UIViewController {


	private let setupProfileView = SetupProfileView()

	override func loadView() {
		self.view = setupProfileView
	}
}



//
//  ProfileViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit

final class ProfileViewController: UIViewController {

	private let containerView = UIView()
	private let imageVIew = UIImageView(image: #imageLiteral(resourceName: "avatar"), contentMode: .scaleAspectFill)
	private let nameLabel = UILabel(text: "Peter", font: .systemFont(ofSize: 28, weight: .light))
	private let aboutLabel = UILabel(text: "Yoy hahe the", font: .systemFont(ofSize: 16, weight: .light))
	private let myTextFIeld = InsertableTextField()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		setupViewApperance()
		setupViewLayout()
		setupActionSend()
	}
}

//MARK: - Action send

private extension ProfileViewController {
	func setupActionSend() {
		if let button = myTextFIeld.rightView as? UIButton {
			button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
		}
	}

	@objc func sendMessage() {
		print(#function)
	}
}

private extension ProfileViewController {
	func setupViewApperance() {
		setupContainerViewApperance()
		setupAboutLabelApperance()


	}

	func setupContainerViewApperance() {
		containerView.backgroundColor = .mainWhite()
		containerView.layer.cornerRadius = 30
	}

	func setupAboutLabelApperance() {
		aboutLabel.numberOfLines = 0

	}
}

private extension ProfileViewController {
	func setupViewLayout() {
		setupContainerView()
		setupImageView()
		setupNameLabel()
		setupAboutLabel()
		setupTextField()

	}

	func setupContainerView() {
		view.addSubview(containerView)
		containerView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			containerView.heightAnchor.constraint(equalToConstant: 205)
		])

	}

	func setupImageView() {
		view.addSubview(imageVIew)
		imageVIew.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			imageVIew.topAnchor.constraint(equalTo: view.topAnchor),
			imageVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			imageVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			imageVIew.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 30)

		])

	}

	func setupNameLabel() {
		containerView.addSubview(nameLabel)
		nameLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 35),
			nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)


		])

	}

	func setupAboutLabel() {
		containerView.addSubview(aboutLabel)
		aboutLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
			aboutLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			aboutLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25)
		])
	}

	func setupTextField() {
		containerView.addSubview(myTextFIeld)
		myTextFIeld.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			myTextFIeld.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
			myTextFIeld.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
			myTextFIeld.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
			myTextFIeld.heightAnchor.constraint(equalToConstant: 50)


		])

	}
}

import SwiftUI

struct ProfileViewControllerd: PreviewProvider {
	static var previews: some View {

		ContainerViewwccc().edgesIgnoringSafeArea(.all)
	}
}

struct ContainerViewwccc: UIViewControllerRepresentable {

	let viewController = ProfileViewController()

	func makeUIViewController(context: Context) -> some UIViewController {
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

	}


}







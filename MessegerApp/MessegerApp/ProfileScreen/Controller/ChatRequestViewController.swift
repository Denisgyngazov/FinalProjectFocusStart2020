//
//  ChatRequestViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit

final class ChatRequestViewController: UIViewController {
	
	//MARK: - Property

	private let chatRequesView = ChatRequestView()
	private var chat: Message
	weak var delegate: WaitingChatDelegate?

	//MARK: - Life Cycle

	override func loadView() {
		self.view = chatRequesView
		setupActionButton()
	}

	//MARK: - Init

	init(chat: Message) {
		self.chat = chat
		chatRequesView.nameLabel.text = chat.friendUsername
		chatRequesView.imageView.sd_setImage(with: URL(string: chat.friendUserImageString), completed: nil)
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
	//MARK: - Setup action button

private extension ChatRequestViewController {
	func setupActionButton() {
		chatRequesView.cancelButton.addTarget(self, action: #selector(setupCancelTapped), for: .touchUpInside)
		chatRequesView.acceptButton.addTarget(self, action: #selector(setupActionTapped), for: .touchUpInside)
	}

	@objc func setupCancelTapped() {
		self.dismiss(animated: true) {
			self.delegate?.removeWaitingChat(chat: self.chat)
		}
	}
	@objc func setupActionTapped() {
		self.dismiss(animated: true) {
			self.delegate?.chatToActive(chat: self.chat)
		}
	}
}


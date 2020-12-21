//
//  WaitingChatDelegate.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 19.12.2020.
//

import Foundation

protocol WaitingChatDelegate: AnyObject  {
	func removeWaitingChat(chat: Message)
	func chatToActive(chat: Message)
}

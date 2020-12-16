//
//  ModelMessage.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

struct Message: Hashable, Decodable {
	var username: String
	var userImageString: String
	var lastMessage: String
	var id: Int

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	static func == (lhs: Message, rhs: Message) -> Bool {
		return lhs.id == rhs.id
	}
}

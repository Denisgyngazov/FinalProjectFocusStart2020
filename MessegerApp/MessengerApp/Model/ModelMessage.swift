//
//  ModelMessage.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit
import FirebaseFirestore

struct Message: Hashable, Decodable {
	var friendUsername: String
	var friendUserImageString: String
	var lastMessage: String
	var id: String

	var representation: [String: Any] {
		var rep = ["friendUsername": friendUsername]
		 rep["friendUserImageString"] = friendUserImageString
		 rep["lastMessage"] = lastMessage
		 rep["id"] = id
		return rep
	}

	init(friendUsername: String, friendUserImageString: String, lastMessage: String, id: String) {
		self.friendUsername = friendUsername
		self.friendUserImageString = friendUserImageString
		self.lastMessage = lastMessage
		self.id = id
	}

	init?(document: QueryDocumentSnapshot) {
		let data = document.data()
		guard let friendUsername = data["friendUsername"] as? String,
			  let friendUserImageString = data["friendUserImageString"] as? String,
			  let lastMessage = data["lastMessage"] as? String,
			  let id = data["id"] as? String else { return nil }

		self.friendUsername = friendUsername
		self.friendUserImageString = friendUserImageString
		self.lastMessage = lastMessage
		self.id = id
	}


	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	static func == (lhs: Message, rhs: Message) -> Bool {
		return lhs.id == rhs.id
	}
}

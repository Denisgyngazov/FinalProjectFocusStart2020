//
//  ModelUser.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import UIKit

struct User: Hashable, Decodable {
	var username: String
	var avatarStringURL: String
	var id: Int

	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	static func == (lhs: User, rhs: User) -> Bool {
		return lhs.id == rhs.id
	}

	func contains(filter: String?) -> Bool {
		guard let filter = filter else { return true}
		if filter.isEmpty { return true }
		let lowercasedFilter = filter.lowercased()
		return username.lowercased().contains(lowercasedFilter)
	}
}

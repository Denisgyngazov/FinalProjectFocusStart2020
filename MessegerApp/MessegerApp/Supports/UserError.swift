//
//  UserError.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import Foundation

enum UserError {
	case notFilled
	case photoNotExist
	case cannotGetUserInfo
	case cannotUnwrapToUser
}

extension UserError: LocalizedError {
	var errorDescription: String? {
		switch self {

		case .notFilled:
			return NSLocalizedString("Not all fields are filled", comment: "")
		case .photoNotExist:
			return NSLocalizedString("User has not selected photo", comment: "")
		case .cannotGetUserInfo:
			return NSLocalizedString("Сannot be loaded from Firebase", comment: "")
		case .cannotUnwrapToUser:
			return NSLocalizedString("Impossible to convert", comment: "")
		}
	}
}

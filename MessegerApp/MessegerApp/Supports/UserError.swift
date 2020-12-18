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
			return NSLocalizedString("Fill in all the fields", comment: "")
		case .photoNotExist:
			return NSLocalizedString("User did not select a photo", comment: "")
		case .cannotGetUserInfo:
			return NSLocalizedString("Невозможно загрузить из firebase", comment: "")
		case .cannotUnwrapToUser:
			return NSLocalizedString("Невозможно конвертировать", comment: "")
		}
	}
}

//
//  AuthenticationError.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import Foundation

enum AuthenticationError {
	case notFilled
	case invalidEmail
	case passwordsNotMatched
	case unknownError
	case serverError
}

extension AuthenticationError: LocalizedError {
	var errorDescription: String? {
		switch self {

		case .notFilled:
			return NSLocalizedString("Fill in all the fields", comment: "")
		case .invalidEmail:
			return NSLocalizedString("Invalid email format", comment: "")
		case .passwordsNotMatched:
			return NSLocalizedString("Passwords do not match", comment: "")
		case .unknownError:
			return NSLocalizedString("Unknown error", comment: "")
		case .serverError:
			return NSLocalizedString("Server error", comment: "")
		}
	}
}

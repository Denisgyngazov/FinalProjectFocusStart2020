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
			return NSLocalizedString("Not all fields are filled", comment: "")
		case .invalidEmail:
			return NSLocalizedString("Wrong format email", comment: "")
		case .passwordsNotMatched:
			return NSLocalizedString("Passwords do not match", comment: "")
		case .unknownError:
			return NSLocalizedString("Unknown error", comment: "")
		case .serverError:
			return NSLocalizedString("Server error", comment: "")
		}
	}
}

//
//  Validators.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import Foundation


final class Validators {
	static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
		guard let password = password,
			  let confirmPassword = confirmPassword,
			  let email = email,
			  password.isEmpty == false,
			  confirmPassword.isEmpty == false,
			  email.isEmpty == false else { return false }

		return true
	}

	static func isFilled(username: String?, description: String?, sex: String?) -> Bool {
		guard let description = description,
			  let sex = sex,
			  let username = username,
			  description.isEmpty == false,
			  sex.isEmpty == false,
			  username.isEmpty == false else { return false }

		return true
	}

	private static func check(text: String, regEx: String) -> Bool {
		let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
		return predicate.evaluate(with: text)
	}

	static func isSimpleEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		return check(text: email, regEx: emailRegEx)
	}
}


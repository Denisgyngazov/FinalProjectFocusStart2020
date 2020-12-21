//
//  AuthenticationService.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 16.12.2020.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

final class AuthenticationService {

	//MARK: - Property
	
	static let shared = AuthenticationService()
	private let auth = Auth.auth()
}

	//MARK: - Login

extension AuthenticationService {
	func login(email: String?, password: String?, completion: @escaping (Result<User,Error>) -> Void) {

		guard let email = email,
			  let password = password else {
			completion(.failure(AuthenticationError.notFilled))
			return
		}
		auth.signIn(withEmail: email , password: password) { (result, error) in
			guard let result = result else {
				completion(.failure(error!))
				return
			}
			completion(.success(result.user))
		}
	}
}

	//MARK: - Registered

extension AuthenticationService {
	func register(email: String?, password: String? , confirmPassword: String?, completion: @escaping (Result<User,Error>) -> Void) {

		guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword) else {
			completion(.failure(AuthenticationError.notFilled))
			return
		}

		guard password?.lowercased() == confirmPassword?.lowercased() else {
			completion(.failure(AuthenticationError.passwordsNotMatched))
			return
		}

		guard Validators.isSimpleEmail(email!) else {
			completion(.failure(AuthenticationError.invalidEmail))
			return
		}


		auth.createUser(withEmail: email!, password: password!) { (result, error) in
			guard let result = result else {
				completion(.failure(error!))
				return
			}
			completion(.success(result.user))
		}
	}
}

	//MARK: - Google Login

extension AuthenticationService {
	func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User,Error>) -> Void) {
		if let error = error {
			completion(.failure(error))
			return
		}
		guard let authentication = user.authentication else { return }
		let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)

		Auth.auth().signIn(with: credential) { (result, error) in
			guard let result = result else {
				completion(.failure(error!))
				return
			}
			completion(.success(result.user))
		}
	}
}

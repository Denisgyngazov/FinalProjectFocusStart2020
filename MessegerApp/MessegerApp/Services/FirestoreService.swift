//
//  FirestoreService.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import Firebase
import FirebaseFirestore

final class FirestoreService {
	static let shared = FirestoreService()

	let dataBase = Firestore.firestore()

	private var usersRef: CollectionReference {
		return dataBase.collection("users")
	}
}

extension FirestoreService {
	func saveProfileWith(id: String, email: String, username: String?, avataImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
		
		guard Validators.isFilled(username: username, description: description, sex: sex) else {
			completion(.failure(UserError.notFilled))
			return
		}

		
		let muser = MUser(username: username!, email: email, avatarStringURL: "not exist", description: description!, sex: sex!, id: id)
		self.usersRef.document(muser.id).setData(muser.representation) { (error) in
			if let error = error {
				completion(.failure(error))
			} else {
				completion(.success(muser))
			}

		}
		
	}
}

extension FirestoreService {
	func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
		let docRef = usersRef.document(user.uid)
		docRef.getDocument { (document, error) in
			if let document = document, document.exists {
				guard let muser = MUser(document: document) else {
					completion(.failure(UserError.cannotUnwrapToUser))
					return
				}
				completion(.success(muser))
			} else {
				completion(.failure(UserError.cannotGetUserInfo))
			}
		}

	}
}

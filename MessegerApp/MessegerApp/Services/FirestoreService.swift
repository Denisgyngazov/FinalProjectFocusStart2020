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

//MARK: - Save profile in Firestore

extension FirestoreService {
	func saveProfileWith(id: String,
						 email: String,
						 username: String?,
						 avatarImage: UIImage?,
						 description: String?,
						 sex: String?,
						 completion: @escaping (Result<MUser, Error>) -> Void) {
		
		guard Validators.isFilled(username: username, description: description, sex: sex) else {
			completion(.failure(UserError.notFilled))
			return
		}

		guard avatarImage != #imageLiteral(resourceName: "avatar") else {
			completion(.failure(UserError.photoNotExist))
			return
		}

		
		var muser = MUser(username: username!,
						  email: email,
						  avatarStringURL: "not exist",
						  description: description!,
						  sex: sex!,
						  id: id)
		StorageService.shared.upload(photo: avatarImage!) { (result) in
			switch result {

			case .success(let url):
				muser.avatarStringURL = url.absoluteString
				self.usersRef.document(muser.id).setData(muser.representation) { (error) in
					if let error = error {
						completion(.failure(error))
					} else {
						completion(.success(muser))
					}

				}
			case .failure(let error):
				completion(.failure(error))

			}
		}
	}
}

//MARK: - Get user data

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

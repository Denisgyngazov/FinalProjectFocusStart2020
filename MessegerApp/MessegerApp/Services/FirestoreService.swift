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

	private var currentUser: MUser!
	private var waitingChatReference: CollectionReference {
		return dataBase.collection(["users", currentUser.id, "waitingChat"].joined(separator: "/"))
	}
	private var activeChatReference: CollectionReference {
		return dataBase.collection(["users", currentUser.id, "activeChat"].joined(separator: "/"))
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

//MARK: - Delete waiting chat

extension FirestoreService {
	func deleteWaitingChat(chat: Message, completion: @escaping (Result<Void, Error>) -> Void) {
		waitingChatReference.document(chat.id).delete { (error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			self.deleteMessages(chat: chat, completion: completion)
		}

	}

	func deleteMessages(chat: Message, completion: @escaping (Result<Void, Error>) -> Void) {
		let reference = waitingChatReference.document(chat.id).collection("messages")
		getWaitingChatMessages(chat: chat) { (result) in
			switch result {

			case .success(let messages):
				for message in messages {
					guard let documentId = message.id else { return }
					let messagesReference = reference.document(documentId)
					messagesReference.delete { (error) in
						if let error = error {
							completion(.failure(error))
							return
						}
						completion(.success(Void()))
					}
				}

			case .failure(let error):
				completion(.failure(error))
			}
		}

	}


	 func getWaitingChatMessages(chat: Message, completion: @escaping (Result<[BodyMessage], Error>) -> Void) {
		let reference = waitingChatReference.document(chat.id).collection("messages")
		var messages = [BodyMessage]()
		reference.getDocuments { (quartSnapshot, error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			for document in quartSnapshot!.documents {
				guard let message = BodyMessage(document: document) else { return }
				messages.append(message)
			}
			completion(.success(messages))
		}
	}
}

//MARK: - Change to actiave chat

extension FirestoreService {
	func changeToActive(chat: Message, completion: @escaping (Result<Void, Error>) -> Void) {
		getWaitingChatMessages(chat: chat) { (result) in
			switch result {

			case .success(let messages):
				self.deleteWaitingChat(chat: chat) { (result) in
					switch result {

					case .success():
						self.createActiveChat(chat: chat, messages: messages) { (result) in
							switch result {

							case .success():
								completion(.success(Void()))
							case .failure(let error):
								completion(.failure(error))
							}
						}
					case .failure(let error):
						completion(.failure(error))
					}
				}
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	func createActiveChat(chat: Message, messages: [BodyMessage], completion: @escaping (Result<Void, Error>) -> Void) {
		let messageRefference = activeChatReference.document(chat.id).collection("messages")
		activeChatReference.document(chat.id).setData(chat.representation) { (error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			for message in messages {
				messageRefference.addDocument(data: message.representation) { (error) in
					if let error = error {
						completion(.failure(error))
						return
					}
					completion(.success(Void()))
				}
			}
		}
	}
}

//MARK: - Create waiting chat

extension FirestoreService {
	func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
		let reference = dataBase.collection(["users", receiver.id, "waitingChat"].joined(separator: "/"))
		let messageReference = reference.document(self.currentUser.id).collection("messages")
		let message = BodyMessage(user: currentUser , content: message)
		let chat = Message(friendUsername: currentUser.username,
						   friendUserImageString: currentUser.avatarStringURL,
						   lastMessage: message.content,
						   id: currentUser.id)

		reference.document(currentUser.id).setData(chat.representation) { (error) in
			if let error = error {
				completion(.failure(error))
				return
			}
			messageReference.addDocument(data: message.representation) { (error) in
				if let error = error {
					completion(.failure(error))
					return
				}
				completion(.success(Void()))
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
				self.currentUser = muser
				completion(.success(muser))
			} else {
				completion(.failure(UserError.cannotGetUserInfo))
			}
		}
	}
}

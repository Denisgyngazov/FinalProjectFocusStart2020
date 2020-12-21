//
//  ListenerService.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 18.12.2020.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

final class ListenerService {
	
	//MARK: - Property

	static let shared = ListenerService()

	private let database = Firestore.firestore()

	private var usersRef: CollectionReference {
		return database.collection("users")

	}

	private var currentUserId: String {
		return Auth.auth().currentUser!.uid
	}
}

	//MARK: - Observer waiting chat

extension ListenerService {
	func waitingChatsObserve(chats: [Message], completion: @escaping (Result<[Message], Error>) -> Void) -> ListenerRegistration? {
		var chats = chats
		let chatsRef = database.collection(["users", currentUserId, "waitingChat"].joined(separator: "/"))
		let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
			guard let snapshot = querySnapshot else {
				completion(.failure(error!))
				return
			}
			snapshot.documentChanges.forEach { (diff) in
				guard let chat = Message(document: diff.document) else { return }
				switch diff.type {

				case .added:
					guard !chats.contains(chat) else { return }
					chats.append(chat)

				case .modified:
					guard let index = chats.firstIndex(of: chat) else { return }
					chats[index] = chat

				case .removed:
					guard let index = chats.firstIndex(of: chat) else { return }
					chats.remove(at: index)
				}

			}
			completion(.success(chats))
		}
		return chatsListener
	}
}

	//MARK: - Observer active chat

extension ListenerService {
	func activeChatsObserve(chats: [Message], completion: @escaping (Result<[Message], Error>) -> Void) -> ListenerRegistration? {
		var chats = chats
		let chatsRef = database.collection(["users", currentUserId, "activeChat"].joined(separator: "/"))
		let chatsListener = chatsRef.addSnapshotListener { (querySnapshot, error) in
			guard let snapshot = querySnapshot else {
				completion(.failure(error!))
				return
			}
			snapshot.documentChanges.forEach { (diff) in
				guard let chat = Message(document: diff.document) else { return }
				switch diff.type {

				case .added:
					guard !chats.contains(chat) else { return }
					chats.append(chat)

				case .modified:
					guard let index = chats.firstIndex(of: chat) else { return }
					chats[index] = chat

				case .removed:
					guard let index = chats.firstIndex(of: chat) else { return }
					chats.remove(at: index)
				}

			}
			completion(.success(chats))
		}
		return chatsListener
	}

}

	//MARK: - Observer user

extension ListenerService {
	func usersObserve(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration? {
		var users = users
		let usersListener = usersRef.addSnapshotListener { (querySnapshot, error) in
			guard let snapshot = querySnapshot else {
				completion(.failure(error!))
				return
			}
			snapshot.documentChanges.forEach { (diff) in
				guard let user = MUser(document: diff.document) else { return }
				switch diff.type {

				case .added:
					guard !users.contains(user) else { return }
					guard user.id != self.currentUserId else { return }
					users.append(user)

				case .modified:
					guard let index = users.firstIndex(of: user) else { return }
					users[index] = user

				case .removed:
					guard let index = users.firstIndex(of: user) else { return }
					users.remove(at: index)
				}
			}
			completion(.success(users))
		}
		return usersListener
	}
}

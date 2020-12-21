//
//  ListViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit
import FirebaseFirestore

final class ListViewController: UIViewController {

//MARK: - Property

	private enum Metrics {
		static let waitingChats: String = "Waiting chat"
		static let activeChats: String = "Active chat"
		static let titleErrorAllertControl: String = "Error!"
		static let titleSucessAllertControl: String = "Succes!"
	}

	private enum Layout {
		static let interSectionSpacing: CGFloat = 20
		static let activeChatsInterGroupSpacing: CGFloat = 8
		static let waitingChatsinterGroupSpacing: CGFloat = 18
		static let fractionalWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
		static let fractionalHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
		static let activeChatsAbsolute: NSCollectionLayoutDimension = .absolute(74)
		static let waitingChatsAbsolute: NSCollectionLayoutDimension = .absolute(88)
		static let headerChatsEstimated: NSCollectionLayoutDimension = .estimated(1)
		static let contentInsetsTop: CGFloat = 16
		static let contentInsetsLeading: CGFloat = 20
		static let contentInsetsBottom: CGFloat = 0
		static let contentInsetsTrailing: CGFloat = 20
	}

	private enum Section: Int, CaseIterable {
		case waitingChats
		case activeChats

		func description() -> String {
			switch self {
			case .waitingChats:
				return Metrics.waitingChats
			case .activeChats:
				return Metrics.activeChats
			}
		}
	}
	
	private let currentUser: MUser
	private var dataSource: UICollectionViewDiffableDataSource<Section, Message>?
	private var waitingChatsListener: ListenerRegistration?
	private var activeChatsListener: ListenerRegistration?
	private var waitingChats = [Message]()
	private var activeChats = [Message]()

	//MARK: - View

	private var collectionView: UICollectionView!

	//MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setupSearchBar()
		setupCollectionView()
		setupDataSource()
		reloadData()
		setupAddWaitingAndActiveChat()
	}

	//MARK: - Init

	init(currentUser: MUser) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)
		title = currentUser.username
	}
	//MARK: - Deinit

	deinit {
		waitingChatsListener?.remove()
		activeChatsListener?.remove()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Setup CollectionView

private extension ListViewController {
	func setupCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.backgroundColor = .mainWhite()
		view.addSubview(collectionView)

		collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifaer)

		collectionView.register(ActiveChatCell.self, forCellWithReuseIdentifier: ActiveChatCell.identifaer)
		collectionView.register(WaitingChatCell.self, forCellWithReuseIdentifier: WaitingChatCell.identifaer)

		collectionView.delegate = self
	}
}

//MARK: - Add waiting and active chat on view

private extension ListViewController {
	func setupAddWaitingAndActiveChat() {
		waitingChatsListener = ListenerService.shared.waitingChatsObserve(chats: waitingChats, completion: { (result) in
			switch result {

			case .success(let chats):
				if self.waitingChats != [] , self.waitingChats.count <= chats.count {
					let chatRequestViewController = ChatRequestViewController(chat: chats.last!)
					chatRequestViewController.delegate = self
					self.present(chatRequestViewController, animated: true, completion: nil)
				}
				self.waitingChats = chats
				self.reloadData()
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		})
		activeChatsListener = ListenerService.shared.activeChatsObserve(chats: activeChats, completion: { (result) in
			switch result {

			case .success(let chats):
				self.activeChats = chats
				self.reloadData()
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		})
	}
}

//MARK: - Delegate UICollectionView

extension ListViewController: WaitingChatDelegate {
	func removeWaitingChat(chat: Message) {
		FirestoreService.shared.deleteWaitingChat(chat: chat) { (result) in
			switch result {

			case .success():
				self.showAllertController(title: Metrics.titleSucessAllertControl,
										  message: "Chat with \(chat.friendUsername) was removed")
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		}
	}

	func chatToActive(chat: Message) {
		FirestoreService.shared.changeToActive(chat: chat) { (result) in
			switch result {

			case .success():
				self.showAllertController(title: Metrics.titleSucessAllertControl,
										  message: "Have a nice chat \(chat.friendUsername)")
			case .failure(let error):
				self.showAllertController(title: Metrics.titleErrorAllertControl,
										  message: error.localizedDescription)
			}
		}
	}
}

//MARK: Delegate tap on waiting chats

extension ListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let chat = self.dataSource?.itemIdentifier(for: indexPath) else { return }
		guard let section = Section(rawValue: indexPath.section) else { return }

		switch section {

		case .waitingChats:
			let chatRequestViewController = ChatRequestViewController(chat: chat)
			chatRequestViewController.delegate = self
			self.present(chatRequestViewController, animated: true, completion: nil)
		case .activeChats:
			print(indexPath)
		}
	}
}

	//MARK: - Data Source

private extension ListViewController {
	func setupDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, Message>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, chat) -> UICollectionViewCell? in
			guard let section = Section(rawValue: indexPath.section) else {
				fatalError("Unknown section kind")
			}

			switch section {

			case .waitingChats:
				return self.configure(collectionView: collectionView, cellType: WaitingChatCell.self, with: chat, for: indexPath)

			case .activeChats:
				return self.configure(collectionView: collectionView, cellType: ActiveChatCell.self, with: chat, for: indexPath)
			}
		})

		//MARK: - Section header

		dataSource?.supplementaryViewProvider = {
			collectionView, kind , indexPath in
			guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifaer, for: indexPath) as? SectionHeader else {  fatalError("Can not create new section header")}
			guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
			sectionHeader.configure(text: section.description(),
									font: .laoSangam20(),
									textColor: .sectionHeader())
			return sectionHeader
		}
	}
}

	// MARK: - Reload Data

private extension ListViewController {
	func reloadData() {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Message>()
		snapshot.appendSections([.waitingChats, .activeChats])
		snapshot.appendItems(waitingChats, toSection: .waitingChats)
		snapshot.appendItems(activeChats, toSection: .activeChats)

		dataSource?.apply(snapshot, animatingDifferences: true)
	}
}

	// MARK: - Layout

private extension ListViewController {
	func setupCompositionalLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
			guard let section = Section(rawValue: sectionIndex) else {
				fatalError("Unknown section kind")
			}

			switch section {

			case .waitingChats:
				return self.setupWaitingChats()
			case .activeChats:
				return self.setupActiveChats()
			}
		}

		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = Layout.interSectionSpacing
		layout.configuration = config

		return layout
	}

	func setupActiveChats() -> NSCollectionLayoutSection {
		let sectionHeader = setupHeaderChats()
		let itemSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
											  heightDimension: Layout.fractionalHeight)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)

		let groupSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
											   heightDimension: Layout.activeChatsAbsolute)

		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = Layout.activeChatsInterGroupSpacing
		section.contentInsets = NSDirectionalEdgeInsets.init(top: Layout.contentInsetsTop,
															 leading: Layout.contentInsetsLeading,
															 bottom: Layout.contentInsetsBottom,
															 trailing: Layout.contentInsetsTrailing)
		section.boundarySupplementaryItems = [sectionHeader]

		return section

	}

	func setupWaitingChats() -> NSCollectionLayoutSection {
		let sectionHeader = setupHeaderChats()
		let itemSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
											  heightDimension: Layout.fractionalHeight)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: Layout.waitingChatsAbsolute,
											   heightDimension: Layout.waitingChatsAbsolute)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = Layout.waitingChatsinterGroupSpacing
		section.contentInsets = NSDirectionalEdgeInsets.init(top: Layout.contentInsetsTop,
															 leading: Layout.contentInsetsLeading,
															 bottom: Layout.contentInsetsBottom,
															 trailing: Layout.contentInsetsTrailing)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [sectionHeader]

		return section
	}

	func setupHeaderChats() -> NSCollectionLayoutBoundarySupplementaryItem {
		let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
													   heightDimension: Layout.headerChatsEstimated)
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

		return sectionHeader
	}
}

//MARK: - Setup search bar

private extension ListViewController {
	func setupSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.obscuresBackgroundDuringPresentation = false
		navigationController?.navigationBar.barTintColor = .mainWhite()
		navigationController?.navigationBar.shadowImage = UIImage()
	}
}


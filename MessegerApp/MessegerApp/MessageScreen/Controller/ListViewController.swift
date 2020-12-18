//
//  ListViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit

final class ListViewController: UIViewController {

//MARK: - Property

	private enum Section: Int, CaseIterable {
		case waitingChats
		case activeChats

		func description() -> String {
			switch self {
			case .waitingChats:
				return "Waiting chats"
			case .activeChats:
				return "Active chats"
			}
		}
	}
	private let currentUser: MUser
	private var dataSource: UICollectionViewDiffableDataSource<Section, Message>?

	private let waitingChats = Bundle.main.decode([Message].self, from: "waitingChats.json")
	private let activeChats = Bundle.main.decode([Message].self, from: "activeChats.json")

//MARK: - View

	private var collectionView: UICollectionView!

//MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setupSearchBar()
		setupCollectionView()
		setupDataSource()
		reloadData()

	}

	init(currentUser: MUser) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)
		title = currentUser.username
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
			sectionHeader.configure(text: section.description(), font: .laoSangam20(), textColor: #colorLiteral(red: 0.5725490196, green: 0.5725490196, blue: 0.5725490196, alpha: 1))
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
		config.interSectionSpacing = 20
		layout.configuration = config

		return layout
	}

	func setupActiveChats() -> NSCollectionLayoutSection {
		let sectionHeader = setupHeaderChats()
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)

		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(74))

		let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = 8
		section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
		section.boundarySupplementaryItems = [sectionHeader]

		return section

	}

	func setupWaitingChats() -> NSCollectionLayoutSection {
		let sectionHeader = setupHeaderChats()
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(88), heightDimension: .absolute(88))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = 18
		section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 20, bottom: 0, trailing: 20)
		section.orthogonalScrollingBehavior = .continuous
		section.boundarySupplementaryItems = [sectionHeader]

		return section
	}

	func setupHeaderChats() -> NSCollectionLayoutBoundarySupplementaryItem {
		let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

		return sectionHeader

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
	}
}

//MARK: - Setup SearchBar

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




//
//  PeopleViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit
import FirebaseAuth

final class PeopleViewController: UIViewController {

	//private let users = Bundle.main.decode([MUser].self, from: "users.json")
	private let currentUser: MUser
	private let users = [MUser]()
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Section, MUser>?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .blue
		setupSearchBar()
		setupCollectionView()
		setupDataSource()
		reloadData(with: nil)

		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(signOut))


		users.forEach({ (users) in
			print(users.username)
		})

	}

	init(currentUser: MUser) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)
		title = currentUser.username
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	@objc private func signOut() {
		let allertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
		allertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		allertController.addAction((UIAlertAction(title: "Sign out", style: .destructive, handler: { (_) in
			do {
				try Auth.auth().signOut()
				
				UIApplication.shared.keyWindow?.rootViewController = AuthenticationViewController()
			} catch {
				print("Error signing out: \(error.localizedDescription)")
			}
		})))
		present(allertController, animated: true, completion: nil)
	}

	private enum Section: Int, CaseIterable {
		case users

		func description(usersCount: Int) -> String {
			switch self {

			case .users:
				return "\(usersCount) people nearby"
			}
		}


	}
}

extension PeopleViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		reloadData(with: searchText)
	}
}
// MARK: - Data Source

private extension PeopleViewController {
	func setupDataSource() {
		dataSource = UICollectionViewDiffableDataSource<Section, MUser>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, user) -> UICollectionViewCell? in
			guard let section = Section(rawValue: indexPath.section) else {
				fatalError("Unknown section kind")
			}

			switch section {
			case .users:
				return self.configure(collectionView: collectionView, cellType: UserCell.self, with: user, for: indexPath)
			}
		})

//MARK: - Section header

		dataSource?.supplementaryViewProvider = {
			collectionView, kind , indexPath in
			guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseIdentifaer, for: indexPath) as? SectionHeader else {  fatalError("Can not create new section header")}
			guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
			
			let items = self.dataSource?.snapshot().itemIdentifiers(inSection: .users)
			sectionHeader.configure(text: section.description(usersCount: items?.count ?? 0), font: .systemFont(ofSize: 36, weight: .light), textColor: .label)
			return sectionHeader
		}
	}
}

//MARK: - Reload Data
private extension PeopleViewController {
	func reloadData(with searchText: String?) {
		let filteredArray = users.filter { (user) -> Bool in
			user.contains(filter: searchText)
		}

		var snapshot = NSDiffableDataSourceSnapshot<Section, MUser>()
		snapshot.appendSections([.users])
		snapshot.appendItems(filteredArray, toSection: .users)

		dataSource?.apply(snapshot, animatingDifferences: true)
	}
}

// MARK: - Layout

private extension PeopleViewController {
	func setupCompositionalLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
			guard let section = Section(rawValue: sectionIndex) else {
				fatalError("Unknown section kind")
			}

			switch section {

			case .users:
				return self.setupUsersSection()
			}
		}

		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = 20
		layout.configuration = config

		return layout
	}

	func setupUsersSection() -> NSCollectionLayoutSection {
		let sectionHeader = setupSectionHeader()
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.5))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
		group.interItemSpacing = .fixed(15)
		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = 15
		section.contentInsets = NSDirectionalEdgeInsets.init(top: 16, leading: 15, bottom: 0, trailing: 15)
		section.boundarySupplementaryItems = [sectionHeader]
		return section
	}

	func setupSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: sectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

		return sectionHeader

	}
}
 //MARK: - Setup Collection View

private extension PeopleViewController {
	func setupCollectionView() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: setupCompositionalLayout())
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.backgroundColor = .mainWhite()
		view.addSubview(collectionView)

		collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifaer)
		collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.identifaer)

	}
}

// мб вынести?
private extension PeopleViewController {
	func setupSearchBar() {
		let searchController = UISearchController(searchResultsController: nil)
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
		searchController.obscuresBackgroundDuringPresentation = false
		navigationController?.navigationBar.barTintColor = .mainWhite()
		navigationController?.navigationBar.shadowImage = UIImage()
		searchController.searchBar.delegate = self
	}
}


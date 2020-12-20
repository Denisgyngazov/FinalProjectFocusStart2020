//
//  PeopleViewController.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 14.12.2020.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class PeopleViewController: UIViewController {

	//MARK: - Property

	private enum Layout {
		static let interSectionSpacing: CGFloat = 20
		static let userSectionInterGroupSpacing: CGFloat = 15
		static let userSectionInsertItemSpacing: CGFloat = 15
		static let countGroup = 2

		static let fractionalWidth: NSCollectionLayoutDimension = .fractionalWidth(1)
		static let sectionHeaderSizeHeightDimension: NSCollectionLayoutDimension = .estimated(1)
		static let fractionalHeight: NSCollectionLayoutDimension = .fractionalHeight(1)
		static let groupSizewidthDimension: NSCollectionLayoutDimension = .fractionalWidth(1.0)
		static let groupSizeHeightDimension: NSCollectionLayoutDimension = .fractionalWidth(0.5)

		static let contentInsetsTop: CGFloat = 16
		static let contentInsetsLeading: CGFloat = 15
		static let contentInsetsBottom: CGFloat = 0
		static let contentInsetsTrailing: CGFloat = 15
	}

	private enum Metrics {
		static let rightBarButtonItemTitle: String = "Log out"
		static let alertControllerMessage: String = "Do you really want to leave?"
		static let oneAlertActionTitle: String = "Cancel"
		static let twoAlertActionTitle: String = "Log out"

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

	private var usersListener: ListenerRegistration?
	private let currentUser: MUser
	private var users = [MUser]()
	private var collectionView: UICollectionView!
	private var dataSource: UICollectionViewDiffableDataSource<Section, MUser>?

	//MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()
		setupSearchBar()
		setupCollectionView()
		setupDataSource()
		setupUsersListener()
		setupSignOutAction()
	}

	init(currentUser: MUser) {
		self.currentUser = currentUser
		super.init(nibName: nil, bundle: nil)
		title = currentUser.username
	}

	deinit {
		usersListener?.remove()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

//MARK: - Delegate tapped on cell

extension PeopleViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let user = self.dataSource?.itemIdentifier(for: indexPath) else { return }
		let profileViewController = ProfileViewController(user: user)
		present(profileViewController, animated: true, completion: nil)
	}
}

//MARK: - Setup users listener

extension PeopleViewController {
	func setupUsersListener() {
		usersListener = ListenerService.shared.usersObserve(users: users, completion: { (result) in
			switch result {

			case .success(let users):
				self.users = users
				self.reloadData(with: nil)

			case .failure(let error):
				self.showAllertController(title: "Error!", message: error.localizedDescription)
			}
		})
	}
}


//MARK: - Delegate search bar

extension PeopleViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		reloadData(with: searchText)
	}
}

//MARK: - Setup Sign out action
private extension PeopleViewController {
	func setupSignOutAction() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: Metrics.rightBarButtonItemTitle,
															style: .plain,
															target: self,
															action: #selector(signOut))
	}

	@objc private func signOut() {
		let alertController = UIAlertController(title: nil,
												message: Metrics.alertControllerMessage,
												 preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: Metrics.oneAlertActionTitle,
												style: .cancel,
												handler: nil))
		alertController.addAction((UIAlertAction(title: Metrics.twoAlertActionTitle,
												 style: .destructive,
												 handler: { (_) in
			do {
				try Auth.auth().signOut()
				UIApplication.shared.keyWindow?.rootViewController = AuthenticationViewController()
			} catch {
				print("Error signing out: \(error.localizedDescription)")
			}
		})))
		present(alertController, animated: true, completion: nil)
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

	   collectionView.delegate = self
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
			sectionHeader.configure(text: section.description(usersCount: items?.count ?? 0),
									font: .systemFont(ofSize: 36, weight: .light),
									textColor: .label)
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
		config.interSectionSpacing = Layout.interSectionSpacing
		layout.configuration = config

		return layout
	}

	func setupUsersSection() -> NSCollectionLayoutSection {
		let sectionHeader = setupSectionHeader()
		let itemSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
											  heightDimension: Layout.fractionalHeight)
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		let groupSize = NSCollectionLayoutSize(widthDimension: Layout.groupSizewidthDimension,
											   heightDimension: Layout.groupSizeHeightDimension)
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
													   subitem: item,
													   count: Layout.countGroup)
		group.interItemSpacing = .fixed(Layout.userSectionInsertItemSpacing)
		let section = NSCollectionLayoutSection(group: group)
		section.interGroupSpacing = Layout.userSectionInterGroupSpacing
		section.contentInsets = NSDirectionalEdgeInsets.init(top: Layout.contentInsetsTop,
															 leading: Layout.contentInsetsLeading,
															 bottom: Layout.contentInsetsBottom,
															 trailing: Layout.contentInsetsTrailing)
		section.boundarySupplementaryItems = [sectionHeader]
		return section
	}

	func setupSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
		let sectionHeaderSize = NSCollectionLayoutSize(widthDimension: Layout.fractionalWidth,
													   heightDimension: Layout.sectionHeaderSizeHeightDimension)
		let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem (layoutSize: sectionHeaderSize,
																		 elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)

		return sectionHeader
	}
}

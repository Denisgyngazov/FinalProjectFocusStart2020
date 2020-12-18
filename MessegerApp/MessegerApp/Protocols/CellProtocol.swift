//
//  CellProtocol.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 15.12.2020.
//

import Foundation

protocol ConfigureCell {
	static var identifaer: String { get }
	func configure<U: Hashable>(with value: U)

}

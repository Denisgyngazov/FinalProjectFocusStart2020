//
//  AuthenticationDelegateProtocol.swift
//  MessegerApp
//
//  Created by Денис Гынгазов on 17.12.2020.
//

import Foundation

protocol AuthNavigationDelegate: AnyObject {
	func toLoginViewController()
	func toSignUpViewController()
}

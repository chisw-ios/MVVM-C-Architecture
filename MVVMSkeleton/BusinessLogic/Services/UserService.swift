//
//  UserService.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation
import KeychainAccess

protocol UserService {
    var isAuthorized: Bool { get }
    var token: String? { get }
    var email: String? { get }
    var name: String? { get }
    var userId: String? { get }
    
    func save(user: SignInResponse)
    func clear()
}

final class UserServiceImpl: UserService {
    var isAuthorized: Bool {
        keychain[Keys.token] != nil
    }
    
    var token: String? {
        keychain[Keys.token]
    }
    
    var email: String? {
        keychain[Keys.email]
    }
    
    var name: String? {
        keychain[Keys.name]
    }
    
    var userId: String? {
        keychain[Keys.userId]
    }
    
    private let keychain: Keychain
    private let configuration: AppConfiguration
    
    init(configuration: AppConfiguration) {
        self.configuration = configuration
        self.keychain = Keychain(service: configuration.bundleId)
    }
    
    func save(user: SignInResponse) {
        keychain[Keys.userId] = user.id
        keychain[Keys.name] = user.name
        keychain[Keys.email] = user.email
        keychain[Keys.token] = user.accessToken
    }
    
    func clear() {
        keychain[Keys.userId] = nil
        keychain[Keys.name] = nil
        keychain[Keys.email] = nil
        keychain[Keys.token] = nil
    }
}
extension UserServiceImpl {
    private enum Keys: CaseIterable {
        static let token = "secure_token_key"
        static let email = "secure_email_key"
        static let name = "secure_name_key"
        static let userId = "secure_userId_key"
    }
}

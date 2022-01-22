//
//  UserService.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation
import KeychainAccess

protocol UserService: AnyObject {
    var isAuthorized: Bool { get }
    var token: String? { get }
    var refreshToken: String? { get }
    
    func save(_ model: UserAuthModel)
    func clear()
}

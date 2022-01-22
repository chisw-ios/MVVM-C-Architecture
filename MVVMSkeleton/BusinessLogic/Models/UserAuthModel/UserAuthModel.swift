//
//  UserAuthModel.swift
//  MVVMSkeleton
//
//  Created by user on 22.01.2022.
//

import Foundation

protocol UserAuthModel {
    var idToken: String { get }
    var refreshToken: String { get }
}

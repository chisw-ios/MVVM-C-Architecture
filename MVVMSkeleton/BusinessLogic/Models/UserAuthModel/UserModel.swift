//
//  UserModel.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation

struct UserModel: Decodable, UserAuthModel {
    let idToken: String
    let refreshToken: String
}

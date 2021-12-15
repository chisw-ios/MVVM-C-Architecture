//
//  AuthService.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import Foundation
import Combine

enum CustomError: Error {
    case authError
}

struct SignInResponse: Decodable {
    let id: String
    let name: String
    let email: String
    let accessToken: String
}

struct SignUpResponse: Decodable {
    let id: String
    let name: String
    let email: String
    let accessToken: String
}

protocol AuthService {
    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, CustomError>
    func signUp(email: String, password: String) -> AnyPublisher<Bool, CustomError>
}

class AuthServiceImpl: AuthService {
    
    func signIn(email: String, password: String) -> AnyPublisher<SignInResponse, CustomError> {
        Future<SignInResponse, CustomError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if password.count > 8 {
                    let model = SignInResponse(id: UUID().uuidString,
                                               name: "Username",
                                               email: email,
                                               accessToken: UUID().uuidString)
                    promise(.success(model))
                } else {
                    promise(.failure(.authError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func signUp(email: String, password: String) -> AnyPublisher<Bool, CustomError> {
        Future<Bool, CustomError> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if password.count > 4 {
                    promise(.success(true))
                } else {
                    promise(.failure(.authError))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

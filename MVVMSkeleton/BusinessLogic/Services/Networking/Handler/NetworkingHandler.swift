//
//  NetworkingHandler.swift
//  MVVMSkeleton
//
//  Created by user on 19.01.2022.
//

import Foundation
import CombineNetworking
import Combine

class NetworkingHandler {
    public var tokenService: TokenService!
    public var userService: UserService!
}

// MARK: - CNErrorHandler
extension NetworkingHandler: CNErrorHandler {
    public func outputHandling(
        _ output: NetworingOutput,
        _ retryMethod: @autoclosure @escaping () -> AnyPublisher<Data, CNError>
    ) -> AnyPublisher<Data, CNError> {
            
        guard let httpResponse = output.response as? HTTPURLResponse else {
            return Fail(error: CNError.unspecifiedError)
                .eraseToAnyPublisher()
        }
        
        switch httpResponse.statusCode {
        case 200...399:
            return Just(output.data)
                .setFailureType(to: CNError.self)
                .eraseToAnyPublisher()
            
        case 401:
            guard let refreshToken = userService.refreshToken else {
                return Fail(error: CNError.clientError)
                    .eraseToAnyPublisher()
            }
            
            let model = TokenRequestModel(refreshToken: refreshToken)
            return tokenService.refreshToken(model)
                .flatMap { [weak userService] response -> AnyPublisher<Data, CNError> in
                    userService?.save(response)
                    
                    return retryMethod()
                }
                .eraseToAnyPublisher()
            
        case 400...499:
            return Fail(error: CNError.clientError)
                .eraseToAnyPublisher()
            
        case 500...599:
            return Fail(error: CNError.serverError)
                .eraseToAnyPublisher()
            
        default:
            return Fail(error: CNError.unspecifiedError)
                .eraseToAnyPublisher()
        }
    }
    
    public func convert(error: NSError) -> CNError {
        switch error.code {
        case NSURLErrorBadURL:
            return .badURLError
            
        case NSURLErrorTimedOut:
            return .timedOutError
            
        case NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            return .hostError
            
        case NSURLErrorHTTPTooManyRedirects:
            return .tooManyRedirectsError
            
        case NSURLErrorResourceUnavailable:
            return .resourceUnavailable
            
        case NSURLErrorNotConnectedToInternet, NSURLErrorCallIsActive,
            NSURLErrorNetworkConnectionLost, NSURLErrorDataNotAllowed:
            return .reachabilityError
            
        default: return .unspecifiedError
        }
    }
}

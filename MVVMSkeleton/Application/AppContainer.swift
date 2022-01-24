//
//  AppContainer.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation
import CombineNetworking
import Swinject

protocol AppContainer: AnyObject {
    var appConfiguration: AppConfiguration { get }
    var userService: UserService { get }
    var authService: AuthService { get }
    var tokenService: TokenService { get }
    var characterService: CharactersService { get }
}

// TODO: - Add comments about Assembly
// TODO: - When u will add Swinject code to proj – add descriptions to all of the methods
final class AppContainerImpl: AppContainer {
    // MARK: - Public Properties
    public var appConfiguration: AppConfiguration { resolve() }
    public var userService: UserService { resolve() }
    public var authService: AuthService { resolve() }
    public var tokenService: TokenService { resolve() }
    public var characterService: CharactersService { resolve() }
    
    // MARK: - Private Properties
    private let container = Container()
    
    // MARK: - Init
    required init() {
        registerServices()
    }
}

// MARK: - Private Methods
private extension AppContainerImpl {
    func registerServices() {
        registerAppConfiguration()
        registerUserService()
        registerTokenPlugin()
        registerNetworkingHandler()
        registerTokenService()
        registerAuthService()
        registerCharactersService()
    }
    
    func resolve<T>() -> T {
        container.resolve(T.self)!
    }
    
    func registerAppConfiguration() {
        container.register(AppConfiguration.self) { _ in
            AppConfigurationImpl()
        }
        .inObjectScope(.container)
    }
    
    func registerUserService() {
        container.register(UserService.self) { resolver in
            let configuration = resolver.resolve(AppConfiguration.self)!
            
            return UserServiceImpl(bundleId: configuration.bundleId)
        }
        .inObjectScope(.container)
    }
    
    func registerTokenPlugin() {
        container.register(TokenPlugin.self) { resolver in
            let userService = resolver.resolve(UserService.self)!
            
            return TokenPlugin(userService)
        }
        .inObjectScope(.transient)
    }
    
    func registerNetworkingHandler() {
        container.register(NetworkingHandler.self) { _ in
            NetworkingHandler()
        }
        .initCompleted { resolver, handler in
            handler.tokenService = resolver.resolve(TokenService.self)!
            handler.userService = resolver.resolve(UserService.self)!
        }
    }
    
    func registerTokenService() {
        container.register(TokenService.self) { resolver in
            let appConfiguration = resolver.resolve(AppConfiguration.self)!
            let networkingHandler = resolver.resolve(NetworkingHandler.self)!
            let jsonPugin = JSONContentPlugin()
            let keyPlugin = APIKeyPlugin(
                key: appConfiguration.environment.authAPIKey
            )
            
            let provider = CNProvider(
                baseURL: appConfiguration.environment.tokenBaseURL,
                errorHandler: networkingHandler,
                requestBuilder: TokenAPIRequestBuilder.self,
                plugins: [jsonPugin, keyPlugin]
            )
            
            return TokenServiceImpl(provider)
        }
    }
    
    func registerAuthService() {
        container.register(AuthService.self) { resolver in
            let appConfiguration = resolver.resolve(AppConfiguration.self)!
            let networkingHandler = resolver.resolve(NetworkingHandler.self)!
            let jsonPugin = JSONContentPlugin()
            let keyPlugin = APIKeyPlugin(
                key: appConfiguration.environment.authAPIKey
            )
            
            let provider = CNProvider(
                baseURL: appConfiguration.environment.authBaseURL,
                errorHandler: networkingHandler,
                requestBuilder: AuthAPIRequestBuilder.self,
                plugins: [jsonPugin, keyPlugin]
            )
            
            return AuthServiceImpl(provider)
        }
    }
    
    func registerCharactersService() {
        container.register(CharactersService.self) { resolver in
            let appConfiguration = resolver.resolve(AppConfiguration.self)!
            let networkingHandler = resolver.resolve(NetworkingHandler.self)!
            let userService = resolver.resolve(UserService.self)!
            let jsonPugin = JSONContentPlugin()
            let tokenPlugin = TokenPlugin(userService)
            
            let provider = CNProvider(
                baseURL: appConfiguration.environment.storageBaseURL,
                errorHandler: networkingHandler,
                requestBuilder: CharactersAPIRequestBuilder.self,
                plugins: [jsonPugin, tokenPlugin]
            )
            
            return CharactersServiceImpl(provider)
        }
    }
}

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

final class AppContainerImpl: AppContainer {
    // MARK: - Public Properties
    public var appConfiguration: AppConfiguration { resolve() }
    public var userService: UserService { resolve() }
    public var authService: AuthService { resolve() }
    public var tokenService: TokenService { resolve() }
    public var characterService: CharactersService { resolve() }
    
    // MARK: - Private Properties
    /// Swinject class represents a dependency injection container, which stores registrations of services and retrieves registered services with dependencies injected.
    ///
    /// Used as a private property, and not used outside the class. This is done so that if you change the library you don't have to change the application code.
    ///
    /// More information about the container and working with it can be found here:
    /// https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md
    private let container = Container()
    
    // MARK: - Init
    required init() {
        registerServices()
    }
}

// MARK: - Private Methods
private extension AppContainerImpl {
    /// In this example, all services are registered directly into the container.
    ///
    /// Learn how to register services here:
    /// https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md#registration-in-a-di-container
    ///
    /// If your project has many services and you want to split their registration into modules, you can use **Assembler** and **Assembly**.
    ///
    /// More about Assembler and Assembly:
    /// https://github.com/Swinject/Swinject/blob/master/Documentation/Assembler.md
    func registerServices() {
        registerAppConfiguration()
        registerUserService()
        registerTokenPlugin()
        registerNetworkingHandler()
        registerTokenService()
        registerAuthService()
        registerCharactersService()
    }
    
    /// A lightweight method that return a specific service from the Swinject container.
    ///
    /// You can see more examples of how to use the resolve method here:
    /// https://github.com/Swinject/Swinject/blob/master/Documentation/DIContainer.md
    func resolve<T>() -> T {
        container.resolve(T.self)!
    }
    
    func registerAppConfiguration() {
        container.register(AppConfiguration.self) { _ in
            AppConfigurationImpl()
        }
        /// The first time you invoke the resolve method with Container Object Scope, Swinject caches the service, and returns the same instance each subsequent time.
        ///
        ///  You can read more about this and other types of object scope here:
        ///  https://github.com/Swinject/Swinject/blob/master/Documentation/ObjectScopes.md
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
    }
    
    func registerNetworkingHandler() {
        container.register(NetworkingHandler.self) { _ in
            NetworkingHandler()
        }
        /// The initCompleted method is used when we need to make a property injection after the other services in the graph have been initialised.
        ///
        /// **This method helps to solve Circular Dependencies.** In this case the method is used because NetworkingHandler requires TokenService, and at the same time TokenService requires NetworkingHandler.
        /// With initCompleted and property injection we initialise the NetworkingHandler with empty properties, and only after the whole graph is initialised we will add TokenService to it.
        ///
        /// More about Circular Dependencies here:
        /// https://github.com/Swinject/Swinject/blob/master/Documentation/CircularDependencies.md#circular-dependencies
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
            let tokenPlugin = resolver.resolve(TokenPlugin.self)!
            let jsonPugin = JSONContentPlugin()
            
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

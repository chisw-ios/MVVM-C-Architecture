//
//  AppConfiguration.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 28.11.2021.
//

import Foundation

protocol AppConfiguration {
    var bundleId: String { get }
}

final class AppConfigurationImpl: AppConfiguration {
    let bundleId: String
    let environment: AppEnvironment = .dev
    
    init() {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            fatalError("no bundle info")
        }
        self.bundleId = bundleId
    }
}

enum AppEnvironment: String {
    case dev
    case stg
    case prod

    var baseURL: URL {
        switch self {
        case .dev: return URL(string: "https://api.thedogapi.com/v1")!
        case .stg: return URL(string: "https://api.thedogapi.com/v1")!
        case .prod: return URL(string: "https://api.thedogapi.com/v1")!
        }
    }

    var apiToken: String {
        switch self {
        case .dev: return "60b38a7e-b2b0-4c87-9106-04c900e0cdf5"
        case .stg: return "60b38a7e-b2b0-4c87-9106-04c900e0cdf5"
        case .prod: return "60b38a7e-b2b0-4c87-9106-04c900e0cdf5"
        }
    }
}

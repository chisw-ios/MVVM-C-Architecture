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
    
    init() {
        guard let bundleId = Bundle.main.bundleIdentifier else {
            fatalError("no bundle info")
        }
        self.bundleId = bundleId
    }
}

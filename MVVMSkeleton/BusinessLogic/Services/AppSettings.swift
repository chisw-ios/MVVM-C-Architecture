//
//  AppSettings.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 20.11.2021.
//

import Combine

struct AppSettingsModel {
    var isNotificationsOn: Bool = false
    var isSomeFeatureOn: Bool = false
}

protocol AppSettingsService: AnyObject {
    var settings: AppSettingsModel { get set }
    var settingsPublisher: AnyPublisher<AppSettingsModel, Never> { get }
}

class AppSettingsServiceImpl: AppSettingsService {
    var settings: AppSettingsModel = AppSettingsModel() {
        didSet { settingsSubject.value = settings }
    }
    private(set) lazy var settingsPublisher = settingsSubject.eraseToAnyPublisher()
    private lazy var settingsSubject = CurrentValueSubject<AppSettingsModel, Never>(settings)
}

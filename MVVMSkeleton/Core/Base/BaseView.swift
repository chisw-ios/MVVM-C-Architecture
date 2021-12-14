//
//  BaseView.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 12.12.2021.
//

import UIKit
import Combine
import CombineCocoa

class BaseView: UIView {
    var cancellables = Set<AnyCancellable>()
}

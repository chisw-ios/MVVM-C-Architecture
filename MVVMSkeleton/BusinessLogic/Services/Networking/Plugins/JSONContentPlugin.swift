//
//  JSONContentPlugin.swift
//  MVVMSkeleton
//
//  Created by user on 22.01.2022.
//

import Foundation
import CombineNetworking

struct JSONContentPlugin: CNPlugin {
    func modifyRequest(_ request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}

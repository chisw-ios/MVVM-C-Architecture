//
//  ViewRepresentable.swift
//  MVVMSkeleton
//
//  Created by Roman Savchenko on 14.11.2021.
//

import SwiftUI
import UIKit

struct ViewRepresentable<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ view: View, setup: (View) -> Void = { _ in }) {
        self.view = view
        setup(view)
    }
    
    func makeUIView(context: Context) -> View {
        view
    }
    
    func updateUIView(_ uiView: View, context: Context) { }
}

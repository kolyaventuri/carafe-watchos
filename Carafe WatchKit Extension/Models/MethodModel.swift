//
//  Methods.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import Combine
import UIKit

extension Int: Identifiable {
    public var id: Int {
        self
    }
}

/// A brew method that can be used
struct Method: Identifiable {
    let title: String
    let emoji: String
    let color: UIColor

    var id: String {
        title
    }
}

class MethodModel: ObservableObject {
    @Published var methods: [Method] = [
        Method(title: "Hario v60",
               emoji: "☕",
               color: UIColor.green)
    ]
}

extension Method {
    /// A sample topic used in the preview.
    static let previewMethod = Method(title: "Hario v60", emoji: "☕", color: .white)
}

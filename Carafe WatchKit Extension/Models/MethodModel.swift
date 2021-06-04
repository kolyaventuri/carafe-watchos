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
    
    var steps: [Step]

    var id: String {
        title
    }
}

enum TimerState {
    case start
    case end
    case ignore
}

enum Display {
    case none
    case timer
    case weight
}

/// Individual steps in a brewing method
struct Step {
    let title: String
    let description: String
    
    var timer: TimerState = .ignore
    var timed: Bool = false
    var time: Int = 0
    var display: Display = .none
}

class MethodModel: ObservableObject {
    @Published var methods: [Method] = [
        Method(
            title: "Hario v60",
            emoji: "☕",
            color: UIColor.green,
            steps: [
                Step(title: "Prep", description: "Grind {weight}g of coffee and place a filter in your v60 brewer."),
                Step(title: "Rinse", description: "Boil about {volume}ml of water, and rinse the filter."),
                Step(title: "Wet Grounds", description: "Add {weight}g of coffee to the filter. Create a small well with your finger, {bloomWeight}g of water, and swirl until all grounds are wet.", display: Display.weight),
                Step(title: "Bloom", description: "Wait for coffee to bloom", timer: TimerState.start, timed: true, time: 30, display: Display.weight),
                Step(title: "First Pour", description: "Pour in water at an even rate", timed: true, time: 30, display: Display.weight),
                Step(title: "Second Pour", description: "Pour more slowly", timed: true, time: 30, display: Display.weight),
                Step(title: "Stir + Swirl", description: "Stir once in each direction, and swirl the entire vessel", display: Display.weight),
                Step(title: "Draw Down", description: "Wait for water to meet top of grounds", display: Display.timer),
                Step(title: "Enjoy", description: "Discard grounds and enjoy!", timer: TimerState.end, display: Display.timer)
            ]
        )
    ]
}

extension Method {
    /// A sample topic used in the preview.
    static let previewMethod = Method(title: "Hario v60", emoji: "☕", color: .white, steps: [
        Step(title: "Prep", description: "Grind {weight}g of coffee and place a filter in your v60 brewer."),
        Step(title: "Rinse", description: "Boil about {volume}ml of water, and rinse the filter."),
        Step(title: "Wet Grounds", description: "Add {weight}g of coffee to the filter. Create a small well with your finger, {bloomWeight}g of water, and swirl until all grounds are wet.", display: Display.weight),
        Step(title: "Bloom", description: "Wait for coffee to bloom", timer: TimerState.start, timed: true, time: 5, display: Display.weight),
        Step(title: "First Pour", description: "Pour in water at an even rate", timed: true, time: 5, display: Display.weight),
        Step(title: "Second Pour", description: "Pour more slowly", timed: true, time: 5, display: Display.weight),
        Step(title: "Stir + Swirl", description: "Stir once in each direction, and swirl the entire vessel", display: Display.weight),
        Step(title: "Draw Down", description: "Wait for water to meet top of grounds", display: Display.timer),
        Step(title: "Enjoy", description: "Discard grounds and enjoy!", timer: TimerState.end, display: Display.timer)
    ])
}

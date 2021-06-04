//
//  BrewView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct BrewView: View {
    let method: Method
    let totalWeight: Int = 400

    @State var currentStep: Int = 0
    @State var currentWeight: Int = 0

    @State var seconds: Int = 0
    @State var totalTime: Int = 0
    
    @State var timer: Timer?;
    
    func startCountdown() {
        seconds = step.time + 1
        tickCountdown()
    }
    
    func tickCountdown() {
        seconds -= 1;
        if (seconds == 0) {
            return nextStep()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tickCountdown()
        }
    }
    
    func nextStep() {
        if (currentStep + 1 == method.steps.count) {
            // TODO: Add end screen
        } else {
            currentStep += 1
            if (step.timed) {
                startCountdown()
            }
            
            if (step.timer == TimerState.start) {
                startTimer()
            } else if (step.timer == TimerState.end) {
                endTimer()
            }
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            totalTime += 1
        }
    }
    
    func endTimer() {
        timer?.invalidate()
    }
    
    var step: Step {
        get {
            return method.steps[currentStep]
        }
    }
    
    var time: String {
        get {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.unitsStyle = .positional
            
            return formatter.string(from: TimeInterval(totalTime))!
        }
    }
    
    var header: String {
        get {
            if (step.display == Display.weight) {
                return "\(currentWeight)g / \(totalWeight)g"
            }
            if (step.display == Display.timer) {
                return time;
            }

            return ""
        }
    }
    
    var buttonText: String {
        get {
            if (step.timed) {
                return "Next step in \(seconds)s"
            }

            return "Continue"
        }
    }

    var body: some View {
        VStack {
            step.display != Display.none ? Text(header).font(.title2) : nil
            Spacer()
            Text(step.description)
            Spacer()
            Button(action: {
                nextStep()
            }) {
                Text(buttonText)
            }
                .padding()
            .disabled(step.timed)
        }
        .navigationTitle(step.title)
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView(method: Method.previewMethod)
    }
}

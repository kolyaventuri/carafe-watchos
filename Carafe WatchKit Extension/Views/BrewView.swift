//
//  BrewView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct BrewView: View {
    let method: Method
    let totalWeight: Int

    @State var currentStep: Int = 0
    @State var currentWeight: Double = 0.0

    @State var seconds: Int = 0
    @State var totalTime: Int = 0
    
    @State var timer: Timer?
    @State var isDone: Bool = false
    
    func startCountdown() {
        seconds = step.time + 1
        tickCountdown()
    }
    
    func tickCountdown() {
        seconds -= 1;
        if (step.weightFactor != 0.0 && seconds < step.time) {
            currentWeight += (Double(totalWeight) * step.weightFactor) / Double(step.time)
        }
        
        if (seconds > 0 && seconds <= 3) {
            WKInterfaceDevice.current().play(.click)

        }
        
        if (seconds == 0) {
            return nextStep()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            tickCountdown()
        }
    }
    
    func nextStep() {
        if (currentStep == 0) {
            currentWeight = Double(totalWeight) * 0.12
        }

        if (currentStep + 1 == method.steps.count) {
            isDone = true
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
                return "\(Int(round(currentWeight)))g / \(totalWeight)g"
            }
            if (step.display == Display.timer) {
                return time;
            }

            return ""
        }
    }
    
    var description: String {
        var desc = step.description
        let coffeeWeight = Int(Double(totalWeight) * 0.06)
        desc = desc.replacingOccurrences(of: "{groundWeight}", with: String((coffeeWeight)))
        desc = desc.replacingOccurrences(of: "{bloomWeight}", with: String((coffeeWeight * 2)))

        let boilVolume = Int(Double(totalWeight) * 1.5)

        desc = desc.replacingOccurrences(of: "{boilVolume}", with: String(boilVolume))
        
        return desc
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
        GeometryReader{g in
            VStack {
                step.display != Display.none ? Text(header).font(.title2) : nil
                Spacer()
                Text(description)
                    .font(.system(size: g.size.height > g.size.width ? g.size.width * 0.1: g.size.height * 0.1))
                Spacer()
                if (isDone) {
                    (
                        NavigationLink(destination: HomeView()) {
                            Text(buttonText)
                        }
                            .padding()
                    )
                } else {
                    (
                        Button(action: {
                            nextStep()
                        }) {
                            Text(buttonText)
                        }
                            .disabled(step.timed)
                            .padding()
                    )
                }
            }
            .navigationTitle(step.title)
        }
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            BrewView(method: Method.previewMethod, totalWeight: 400)
        }
    }
}

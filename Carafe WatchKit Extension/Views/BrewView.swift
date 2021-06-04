//
//  BrewView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct BrewView: View {
    @State var currentStep: Int = 0
    let method: Method
    
    func nextStep() {
        if (currentStep + 1 == method.steps.count) {
            // TODO: Add end screen
        } else {
            currentStep += 1
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Text(method.steps[currentStep].description)
            Spacer()
            Button(action: {
                nextStep()
            }) {
                Text("Continue")
            }
                .padding()
        }
        .navigationTitle(method.steps[currentStep].title)
    }
}

struct BrewView_Previews: PreviewProvider {
    static var previews: some View {
        BrewView(method: Method.previewMethod)
    }
}

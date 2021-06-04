//
//  SetupView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct SetupView: View {
    @ObservedObject var model: MethodModel = MethodModel()

    var body: some View {
        List {
            ForEach(model.methods) { method in
                NavigationLink(destination: BrewView(method: method)) {
                    MethodCell(method: method)
                        .frame(height: 100.0)
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle(Text("Brew Method"))
    }
}

struct MethodCell: View {
    var method: Method

    var body: some View {
        HStack {
            Text(method.emoji)
                .font(.title)
            VStack(alignment: .leading) {
                Text(method.title)
                    .font(.system(.headline, design: .rounded))
            }
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}

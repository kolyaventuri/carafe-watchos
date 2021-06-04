//
//  ContentView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct HomeView: View {
    @State var selection: Int? = nil
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .ignoresSafeArea()
                VStack {
                    Text("carafe.")
                        .font(.title)
                        .padding([.top, .leading, .trailing])
                    Text("let's brew")
                        .font(.caption)
                        .padding([.leading, .bottom, .trailing])
                    NavigationLink(destination: SetupView(), tag: 1, selection: $selection) {
                        Image(systemName: "chevron.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }.buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            
    }
}

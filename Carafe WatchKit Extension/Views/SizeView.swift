//
//  SizeView.swift
//  Carafe WatchKit Extension
//
//  Created by Kolya Venturi on 6/4/21.
//

import SwiftUI

struct SizeView: View {
    let method: Method;
    let sizes = 1...15

    var body: some View {
        List {
            ForEach(sizes) { index in
                let size = 200 + (50 * index)
                NavigationLink(destination: BrewView(method: method, totalWeight: size)) {
                    SizeCell(size: size)
                        .frame(height: 100.0)
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle(Text("Brew Size"))
    }
}

struct SizeCell: View {
    var size: Int;

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(size)ml")
                    .font(.system(.headline, design: .rounded))
            }
        }
    }
}

struct SizeView_Previews: PreviewProvider {
    static var previews: some View {
        SizeView(method: Method.previewMethod)
    }
}

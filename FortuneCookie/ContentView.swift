//
//  ContentView.swift
//  FortuneCookie
//
//  Created by Chuyang Zhang on 6/30/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @EnvironmentObject var quoteModel: QuoteModel  // Observe the shared model

    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace


    var body: some View {
        VStack {
            

            Text("🥠 " + quoteModel.quoteText)
                .foregroundStyle(.yellow)
                .font(.custom("Menlo", size: 50))
                .bold()
                .padding()
                .multilineTextAlignment(.center)

        }
        .task {
            await openImmersiveSpace(id: "ImmersiveSpace")
        }
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}

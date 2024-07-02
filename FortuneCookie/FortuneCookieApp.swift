//
//  FortuneCookieApp.swift
//  FortuneCookie
//
//  Created by Chuyang Zhang on 6/30/24.
//

import SwiftUI



@main
struct FortuneCookieApp: App {
    
    @StateObject var quoteModel = QuoteModel()
    

    
    var body: some Scene {
        WindowGroup {

            ContentView()
                .environmentObject(quoteModel)  // Pass the environment object to ContentView
        }
        

        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environmentObject(quoteModel)  // And also to ImmersiveView
        }
    }
    
}

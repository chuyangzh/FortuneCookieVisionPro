//
//  FortuneCookieApp.swift
//  FortuneCookie
//
//  Created by Chuyang Zhang on 6/30/24.
//

import SwiftUI

@main
struct FortuneCookieApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}

//
//  Side_CApp.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import SwiftUI
import SwiftData

@main
struct SideCApp: App {
    
    @StateObject private var mixVM = CMixViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mixVM)
        }
        .modelContainer(for: [CMix.self, CTrack.self])
    }
}

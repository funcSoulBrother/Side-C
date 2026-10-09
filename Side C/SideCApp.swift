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
    
    init() {
        print("FONT FILE:", Bundle.main.url(forResource: "PermanentMarker-Regular", withExtension: "ttf") as Any)
        print("FONT SETTING:", Bundle.main.object(forInfoDictionaryKey: "UIAppFonts") as Any)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mixVM)
        }
        .modelContainer(for: [CMix.self, CTrack.self])
    }
}

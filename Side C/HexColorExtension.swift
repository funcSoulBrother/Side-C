//
//  HexColorExtension.swift
//  Side C
//
//  Created by Daniel Marsh on 4/30/26.
//

//import SwiftUI
//
//extension Color {
//
//    init(hex: String) {
//
//        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//            .replacingOccurrences(of: "#", with: "")
//
//        var rgb: UInt64 = 0
//
//        Scanner(string: hex).scanHexInt64(&rgb)
//
//        let red = Double((rgb >> 16) & 0xFF) / 255
//        let green = Double((rgb >> 8) & 0xFF) / 255
//        let blue = Double(rgb & 0xFF) / 255
//
//        self.init(
//            red: red,
//            green: green,
//            blue: blue
//        )
//    }
//}

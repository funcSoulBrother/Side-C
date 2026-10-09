//
//  ReadableTextModifier.swift
//  Side C
//
//  Created by Daniel Marsh on 8/2/26.
//

import SwiftUI

enum Theme {
    static let darkBackgroundHexes: Set<String> = ["#000000","#006400","#191970"]
}

extension View {
    func readableText(on backgroundHex: String) -> some View {
        foregroundStyle(Theme.darkBackgroundHexes.contains(backgroundHex.uppercased()) ? .white : .black)
    }
}

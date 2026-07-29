//
//  LogoComponent.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import SwiftUI

struct FakeLogoComponent: View {
    var body: some View {
        Rectangle()
            .fill(Color("Fake Logo Color"))
            .frame(height: 75)
            .padding(.horizontal, 10)
            .overlay(
                Text("Side C")
                    .font(.title)
            )
    }
}

#Preview {
    FakeLogoComponent()
    FakeLogoComponent()
    FakeLogoComponent()
}

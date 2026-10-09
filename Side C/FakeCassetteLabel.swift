//
//  LogoComponent.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import SwiftUI

struct FakeCassetteLabel: View {
    var label: String
    var writingSize: CGFloat
    
    var body: some View {
        Rectangle()
            .fill(Color("Fake Logo Color"))
            .frame(height: 75)
            .cornerRadius(10)
            .padding(.horizontal, 10)
            .overlay(
                Text(label)
                    .font(.custom("PermanentMarker-Regular", size: writingSize))
                    .foregroundStyle(.black)
            )
    }
}

#Preview {
    ZStack{
        Color(.black)
            .ignoresSafeArea()
        VStack{
            FakeCassetteLabel(label: "Side C", writingSize: 50)
            FakeCassetteLabel(label: "Semi-Quiet Nights", writingSize: 30)
            FakeCassetteLabel(label: "Workout C-Mix", writingSize: 30)
            FakeCassetteLabel(label: "C-Mix with an unnecessarily long title, cool!", writingSize: 30)
        }
    }
}

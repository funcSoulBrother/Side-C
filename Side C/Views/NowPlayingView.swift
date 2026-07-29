//
//  NowPlayingView.swift
//  Side C
//
//  Created by Daniel Marsh on 4/27/26.
//

import SwiftUI

struct NowPlayingView: View {
    var mix: CMix
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: mix.backgroundColorHex))
                .ignoresSafeArea()
            VStack {
                Text(mix.name)
                    .foregroundStyle(Color(mix.backgroundColorHex == "#000000" ? .white : .black))
                ForEach(mix.cTracks.indices, id: \.self) { index in
                    VStack(alignment: .leading) {
                        Text(mix.cTracks[index].name ?? "Track \(index + 1)")
                            .font(.headline)
                        Text("\(mix.cTracks[index].songIDs.count) songs")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                }
                Text("C-Track Count: \(mix.cTracks.count)")
            }
        }
    }
}

//#Preview {
//    NowPlayingView()
//}

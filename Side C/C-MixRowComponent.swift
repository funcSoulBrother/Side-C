//
//  C-MixRow.swift
//  Side C
//
//  Created by Daniel Marsh on 4/27/26.
//

import SwiftUI

struct CMixRow: View {
    var cMix: CMix
    @Bindable var viewModel: NowPlayingViewModel
    let musicPlayer: MusicPlayer
    
    var body: some View {
        NavigationLink {
//                                    CMixDetailView(mix: mix)
            NowPlayingView(cMix: cMix, viewModel: viewModel, musicPlayer: musicPlayer, shouldStartMix: true)
        } label: {
            HStack {
                Text(cMix.name)
                    .font(.title2)
                Spacer()
                Image(systemName: "play.circle")
                    .font(.title2)
            }
            .foregroundStyle(Color("C Foreground"))
            .padding(.horizontal, 50)
            .padding(.vertical, 15)
        }
        Divider()
    }
}

//#Preview {
//    ZStack {
//        VStack {
//            CMixRow()
//            CMixRow()
//            CMixRow()
//        }
//    }
//}

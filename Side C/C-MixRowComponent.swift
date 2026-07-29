//
//  C-MixRow.swift
//  Side C
//
//  Created by Daniel Marsh on 4/27/26.
//

import SwiftUI

struct CMixRow: View {
    var mix: CMix
    
    var body: some View {
        NavigationLink {
//                                    CMixDetailView(mix: mix)
            NowPlayingView(mix: mix)
        } label: {
            HStack {
                Text(mix.name)
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

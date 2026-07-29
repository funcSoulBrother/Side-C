//
//  NewCTrackView.swift
//  Side C
//
//  Created by Daniel Marsh on 6/11/26.
//

import SwiftUI
import SwiftData
import MediaPlayer

struct NewCTrackView: View {
    let backgroundColorHex: String
    @Binding var cTracks: [CTrack]
    @Environment(\.dismiss) private var dismiss
    @State private var cTrackName = ""
    @State private var songIDs: [UInt64] = []
//    @State private var showingLibrary = false
    var cTrackSongs: [MPMediaItem] {
        MediaLibraryHelper.songs(for: songIDs)
    }
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: backgroundColorHex))
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
                ScrollView{
                    Text("C-Track Name:")
                        .foregroundStyle(Color("C Foreground"))
                        .font(.title2)
                        .fontWeight(.semibold)
                    TextField("C-Track Name (Optional)", text: $cTrackName)
                        .textFieldStyle(.roundedBorder)
                    Text("Temp songIDs count: \(songIDs.count)")
                    Text("Temp cTrackSongs count: \(cTrackSongs.count)")
                    ForEach(cTrackSongs, id: \.persistentID) { song in
                        VStack(alignment: .leading) {
                            Text(song.title ?? "Unknown Title")
                            Text(song.artist ?? "Unknown Artist")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    NavigationLink {
                        LibraryView(backgroundColorHex: backgroundColorHex, songIDs: $songIDs)
                    } label: {
                        HStack {
                            Text("Add Song(s)")
                                .font(.title2)
                            Spacer()
                            Image(systemName: "plus.circle")
                                .font(.title2)
                        }
                        .foregroundStyle(Color("C Foreground"))
                        .padding(.horizontal, 50)
                        .padding(.vertical, 15)
                    }
                }
                Button("Create C-Track") {
                    let cTrack = CTrack(name: cTrackName.isEmpty ? nil : cTrackName, songIDs: songIDs)
                    cTracks.append(cTrack)
                    dismiss()
                }
            }
            .padding()
        }
        .navigationTitle("New C-Track")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//    NavigationView{
//        PreviewContainer()
//    }
//}

//private struct PreviewContainer: View {
//    @State private var tracks: [CTrack] = []
//
//    var body: some View {
//        NewCTrackView(
//            backgroundColorHex: "#F0F0F0",
//            cTracks: $tracks
//        )
//    }
//}


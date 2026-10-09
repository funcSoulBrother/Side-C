//
//  EditCTrackView.swift
//  Side C
//
//  Created by Daniel Marsh on 7/2/26.
//

import SwiftUI
import SwiftData
import MediaPlayer

struct EditCTrackView: View {
    @EnvironmentObject var mixVM: CMixViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Binding var cTrack: CTrack
    let backgroundColorHex: String
    @Binding var cTracks: [CTrack]
    @State private var cTrackName = ""
    @State private var songIDs: [UInt64] = []
//    @State private var showingLibrary = false
    var cTrackSongs: [MPMediaItem] {
        MediaLibraryHelper.songs(for: songIDs)
    }
//    init(cTrack: Binding<CTrack>, backgroundColorHex: String, cTracks: Binding<[CTrack]>) {
//        self._cTrack = cTrack
//        self.backgroundColorHex = backgroundColorHex
//        self._cTracks = cTracks
//        _cTrackName = State(initialValue: cTrack.wrappedValue.name ?? "")
//        _songIDs = State(initialValue: cTrack.wrappedValue.songIDs)
//    }
    
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
                    Text("Temp songIDs count: \($cTrack.songIDs.count)")
                    Text("Temp cTrackSongs count: \(cTrackSongs.count)")
                    ForEach(cTrackSongs, id: \.persistentID) { song in
                        VStack(alignment: .leading) {
                            Text(song.title ?? "Unknown Title")
                            Text(song.artist ?? "Unknown Artist")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .readableText(on: backgroundColorHex)
                        }
                    }
                    NavigationLink {
                        LibraryView(backgroundColorHex: backgroundColorHex, songIDs: $cTrack.songIDs)
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
                Button("Save C-Track Updates") {
                    mixVM.updateCTrack(cTrack, name: cTrackName, songIDs: songIDs, context: context)
                    dismiss()
                }
            }
            .padding()
        }
        .navigationTitle("Edit C-Track")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            cTrackName = cTrack.name ?? ""
            songIDs = cTrack.songIDs
        }
    }
}

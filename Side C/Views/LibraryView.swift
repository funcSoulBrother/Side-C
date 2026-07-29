//
//  LibraryView.swift
//  Side C
//
//  Created by Daniel Marsh on 4/22/26.
//

import SwiftUI
import MediaPlayer

struct LibraryView: View {
    @Environment(\.dismiss) private var dismiss
    let backgroundColorHex: String
    @StateObject private var viewModel = LibraryViewModel()
    @Binding var songIDs: [UInt64]
    @State private var selectedSongIDs: Set<UInt64>
    init(backgroundColorHex: String, songIDs: Binding<[UInt64]>) {
        self.backgroundColorHex = backgroundColorHex
        self._songIDs = songIDs
        _selectedSongIDs = State(initialValue: Set(songIDs.wrappedValue))
    }
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: backgroundColorHex))
                .ignoresSafeArea()
            List(viewModel.filteredSongs, id: \.persistentID) { song in
                HStack {
                    VStack(alignment: .leading) {
                        Text(song.title ?? "Unknown Title")
                        Text(song.artist ?? "Unknown Artist")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    if selectedSongIDs.contains(song.persistentID) {
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSelection(for: song.persistentID)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color(hex: backgroundColorHex))
            .navigationTitle("Pick a Track")
            .searchable(text: $viewModel.searchText, prompt: "Search Title or Artist")
            .onAppear {
                viewModel.loadSongs()
            }
            Button("Save Selection") {
                songIDs = Array(selectedSongIDs)
                dismiss()
            }
        }
    }
    
    private func toggleSelection(for id: UInt64) {
        if selectedSongIDs.contains(id) {
            selectedSongIDs.remove(id)
        } else {
            selectedSongIDs.insert(id)
        }
    }
}

//#Preview {
//    LibraryView(backgroundColorHex: "89F336", songIDs: .constant([]))
//}

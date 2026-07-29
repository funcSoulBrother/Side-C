//
//  LibraryViewModel.swift
//  Side C
//
//  Created by Daniel Marsh on 4/22/26.
//

import MediaPlayer
import SwiftUI
import Combine

class LibraryViewModel: ObservableObject {

    @Published var allSongs: [MPMediaItem] = []
    @Published var searchText: String = ""

    var filteredSongs: [MPMediaItem] {
        if searchText.isEmpty {
            return allSongs
        }

        return allSongs.filter { song in
            let titleMatches =
                song.title?
                    .localizedCaseInsensitiveContains(searchText)
                ?? false
            let artistMatches =
                song.artist?
                    .localizedCaseInsensitiveContains(searchText)
                ?? false
            return titleMatches || artistMatches
        }
    }

    func loadSongs() {
        let query = MPMediaQuery.songs()
        allSongs = query.items ?? []
    }
}

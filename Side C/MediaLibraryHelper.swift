//
//  Untitled.swift
//  Side C
//
//  Created by Daniel Marsh on 7/1/26.
//

import MediaPlayer

struct MediaLibraryHelper {
    
    private static let songsByID: [UInt64: MPMediaItem] = {
        let songs = MPMediaQuery.songs().items ?? []
        return Dictionary(uniqueKeysWithValues: songs.map { ($0.persistentID, $0) })
    }()
    
    static func song(for persistentID: UInt64) -> MPMediaItem? {
        songsByID[persistentID]
    }
    
    static func songs(for persistentIDs: [UInt64]) -> [MPMediaItem] {
        persistentIDs.compactMap { song(for: $0) }
    }
}

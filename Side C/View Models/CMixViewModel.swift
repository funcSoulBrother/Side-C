//
//  CMixViewModel.swift
//  Side C
//
//  Created by Daniel Marsh on 4/23/26.
//

import SwiftUI
import Combine
import SwiftData
import MediaPlayer

class CMixViewModel: ObservableObject {
    
    func addMix(name: String, colorHex: String, cTracks: [CTrack], context: ModelContext) {
        let newMix = CMix(name: name, backgroundColorHex: colorHex, cTracks: cTracks)
        context.insert(newMix)
        do {
            try context.save()
        } catch {
            print("Failed to save mix: \(error)")
        }
    }
    
    func updateMix(_ mix: CMix, name: String, colorHex: String, cTracks: [CTrack], context: ModelContext) {
        mix.name = name
        mix.backgroundColorHex = colorHex
        mix.cTracks = cTracks
        do {
            try context.save()
        } catch {
            print("Failed to update mix: \(error)")
        }
    }
    
    func updateCTrack(_ cTrack: CTrack, name: String, songIDs: [UInt64], context: ModelContext) {
        cTrack.name = name
        cTrack.songIDs = songIDs
        do {
            try context.save()
        } catch {
            print("Failed to update mix: \(error)")
        }
    }
    
    func deleteMix(_ mix: CMix, context: ModelContext) {
        context.delete(mix)
        do {
            try context.save()
        } catch {
            print("Failed to delete mix")
        }
    }
}

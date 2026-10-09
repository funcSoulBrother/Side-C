//
//  NowPlayingViewModel.swift
//  Side C
//
//  Created by Daniel Marsh on 7/5/26.
//
import Foundation
import MediaPlayer

@Observable
class NowPlayingViewModel {
    var currentCMix: CMix?
    var currentCTrack: CTrack?
    var currentSong: MPMediaItem?
    var isPlaying = false
}



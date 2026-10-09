//
//  MusicPlayer.swift
//  Side C
//
//  Created by Daniel Marsh on 7/29/26.
//

import MediaPlayer

final class MusicPlayer {
    let player = MPMusicPlayerController.applicationMusicPlayer

    func play(_ songs: [MPMediaItem]) {
        guard !songs.isEmpty else { return }
        player.setQueue(with: MPMediaItemCollection(items: songs))
        player.play()
    }

    func pause() {
        player.pause()
    }

    func resume() {
        player.play()
    }

    func stop() {
        player.stop()
    }
}

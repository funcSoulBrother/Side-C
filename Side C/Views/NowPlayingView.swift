//
//  NowPlayingView.swift
//  Side C
//
//  Created by Daniel Marsh on 4/27/26.
//

import SwiftUI
import MediaPlayer

struct NowPlayingView: View {
    var cMix: CMix?
    @Bindable var viewModel: NowPlayingViewModel
    let musicPlayer: MusicPlayer
    var shouldStartMix = false
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: cMix?.backgroundColorHex ?? "#89F336"))
                .ignoresSafeArea()
                VStack(spacing: 24) {
                    FakeCassetteLabel(label: cMix?.name ?? "", writingSize: 30)
                    Text(viewModel.currentCTrack?.name ?? "")
                        .readableText(on: cMix?.backgroundColorHex ?? "#89F336")
                    Spacer()
                    HStack {
                        
                        if let artwork = viewModel.currentSong?.artwork,
                           let albumImage = artwork.image(at: CGSize(width: 260, height: 260)) {
                            Image(uiImage: albumImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 125, height: 125)
                        } else {
                            nilAlbumArtwork
                        }
                        
                        VStack(spacing: 6) {
                            Text(viewModel.currentSong?.title ?? "Nothing Playing")
                                .font(.title2.bold())
                                .lineLimit(2)
                                .readableText(on: cMix?.backgroundColorHex ?? "#89F336")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(viewModel.currentSong?.artist ?? "Choose a song to begin")
                                .font(.subheadline)
                                .lineLimit(2)
                                .readableText(on: cMix?.backgroundColorHex ?? "#89F336")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    Slider(value: .constant(0.25))
                        .tint(.accentColor)
                        .disabled(viewModel.currentSong == nil)
                    HStack(spacing: 42) {
                        Button {
                            // Skip to previous track
                        } label: {
                            Image(systemName: "backward.fill")
                                .font(.title2)
                                .readableText(on: cMix?.backgroundColorHex ?? "#89F336")
                        }
                        Button {
                            viewModel.isPlaying.toggle()
                            // Start or pause playback here
                        } label: {
                            Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 64))
                                .readableText(on: cMix?.backgroundColorHex ?? "89F336")
                        }
                        .disabled(viewModel.currentSong == nil)
                        Button {
                            // Skip to next track
                        } label: {
                            Image(systemName: "forward.fill")
                                .font(.title2)
                                .readableText(on: cMix?.backgroundColorHex ?? "89F336")
                        }
                    }
                    .buttonStyle(.plain)
                    if let song = viewModel.currentSong {
                        Text(song.comments ?? "")
                            .readableText(on: cMix?.backgroundColorHex ?? "89F336")
                    }
                    Spacer()
                }
                .padding()
//                .navigationTitle(cMix.name)
//                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    guard shouldStartMix else { return }
                    guard let cMix = cMix else { return }
                    let selections: [(cTrack: CTrack, song: MPMediaItem)] =
                        cMix.cTracks.compactMap { cTrack in
                            let songs = MediaLibraryHelper.songs(for: cTrack.songIDs)
                            guard let randomSong = songs.randomElement() else {
                                return nil // Skip empty C-Tracks
                            }
                            return (cTrack, randomSong)
                        }
                    guard let firstSelection = selections.first else { return }
                    let queue = selections.map { $0.song }

                    viewModel.currentCMix = cMix
                    viewModel.currentCTrack = firstSelection.cTrack
                    viewModel.currentSong = firstSelection.song
                    viewModel.isPlaying = true

                    musicPlayer.play(queue)
                }
                //Song changes reflect on UI
                .onAppear {
                    musicPlayer.player.beginGeneratingPlaybackNotifications()
                }
                .onReceive(NotificationCenter.default.publisher(for: .MPMusicPlayerControllerNowPlayingItemDidChange, object: musicPlayer.player)) { _ in
                    guard let cMix = viewModel.currentCMix else { return }
                    guard let nowPlayingSong = musicPlayer.player.nowPlayingItem else {
                        return
                    }
                    viewModel.currentSong = nowPlayingSong
                    viewModel.currentCTrack = cMix.cTracks.first {
                        $0.songIDs.contains(nowPlayingSong.persistentID)
                    }
                }
                .onDisappear {
                    musicPlayer.player.endGeneratingPlaybackNotifications()
                }
        }
    }
    
    var nilAlbumArtwork: some View {
        Image(systemName: "music.note")
            .font(.system(size: 46))
            .readableText(on: cMix?.backgroundColorHex ?? "#89F336")
            .frame(width: 125, height: 125)
            .background(.gray.opacity(0.15))
    }
}

#Preview {
    var musicPlayer = MusicPlayer()
    let mockCMix = CMix(name: "Your Mom Sucks C-Mix", backgroundColorHex: "#E97451", cTracks: [])

    NavigationStack {
        NowPlayingView(cMix: mockCMix, viewModel: NowPlayingViewModel(), musicPlayer: musicPlayer)
    }
}

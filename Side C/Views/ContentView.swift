//
//  ContentView.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import SwiftUI
import SwiftData
import SwipeActions

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var mixes: [CMix]
    @State private var selectedMix: CMix? //used for SwipeActions Edit button navigation
    @State private var musicPlayer = MusicPlayer()
    @State private var nowPlayingViewModel = NowPlayingViewModel()
    @StateObject var authVM = MusicAuthorizationViewModel()
    @StateObject var mixVM = CMixViewModel()
    //below code makes mock C-Mixes possible in preview
    init(mixVM: CMixViewModel = CMixViewModel()) {
        _mixVM = StateObject(wrappedValue: mixVM)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ColorToGradient.gradient(from: Color("Lime C"))
                    .ignoresSafeArea()
                VStack {
                    FakeCassetteLabel(label: "Side C", writingSize: 50)
                        .padding(.top, 30)
                    ScrollView {
                        NavigationLink {
                            NowPlayingView(cMix: nowPlayingViewModel.currentCMix, viewModel: nowPlayingViewModel, musicPlayer: musicPlayer)
                        } label: {
                            HStack {
                                Text("Now Playing")
                                    .font(.title2)
                                Spacer()
                                Image(systemName: "chevron.right.circle")
                                    .font(.title2)
                            }
                            .foregroundStyle(Color("C Foreground"))
                            .padding(.horizontal, 50)
                            .padding(.vertical, 15)
                        }
                        Divider()
                            .padding(.horizontal, 10)
                        ///LazyVStack
                        LazyVStack(spacing: 12) {
                            ForEach(mixes) { cMix in
                                SwipeView {
                                    CMixRow(cMix: cMix, viewModel: nowPlayingViewModel, musicPlayer: musicPlayer)
//                                        .padding(.trailing, 20)
                                } trailingActions: { swipeContext in
                                    SwipeAction("Edit") {
                                        swipeContext.state.wrappedValue = .closed
                                        selectedMix = cMix
                                    }
//                                    .allowSwipeToTrigger()
                                    SwipeAction("Delete") {
                                        mixVM.deleteMix(cMix, context: context)
                                    }
                                    .swipeActionLabelHorizontalPadding(500)
//                                    .tint(.blue)
                                }
//                                .swipeActionsMaskCornerRadius(0)
                                Divider()
                                    .padding(.horizontal, 10)
                            }
                        }
                        NavigationLink {
                            NewCMixView()
//                                .environmentObject(mixVM)
                        } label: {
                            HStack {
                                Text("Create New C-Mix")
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
                    Spacer()
                }
            }
            .onAppear {
                authVM.requestMusicAccess()
            }
            .navigationDestination(item: $selectedMix) { mix in
                EditCMixView(mix: mix)
            }
        }
    }
}

//#Preview {
//    ContentView()
//}

#Preview {
    ContentView()
}

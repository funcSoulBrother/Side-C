//
//  EditCMixView.swift
//  Side C
//
//  Created by Daniel Marsh on 6/11/26.
//

import SwiftUI
import SwiftData
import SwipeActions

struct EditCMixView: View {
    var mix: CMix
    @EnvironmentObject var mixVM: CMixViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State private var mixName: String
    @State private var selectedColorHex: String
    @State private var cTracks: [CTrack]
    @State private var fullColorChoice = false
    @State private var selectedCTrack: CTrack? //used for SwipeActions Edit button navigation
    
    init(mix: CMix) {
        self.mix = mix
        _selectedColorHex = State(initialValue: mix.backgroundColorHex)
        _mixName = State(initialValue: mix.name)
        _cTracks = State(initialValue: mix.cTracks)
    } // custom initializer so that background color will start as the C-Mix's color and text field will begin with the C-Mix name in it
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: selectedColorHex))
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
//                Text(mix.name)
//                    .font(.largeTitle)
//                    .fontWeight(.semibold)
//                    .multilineTextAlignment(.center)
//                    .frame(maxWidth: .infinity, alignment: .center)
                ScrollView {
                    Text("C-Mix Name:")
                        .foregroundStyle(Color("C Foreground"))
                        .font(.title2)
                        .fontWeight(.semibold)
                    TextField("Name", text: $mixName)
                        .textFieldStyle(.roundedBorder)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("C-Mix Color:")
                            .foregroundStyle(Color("C Foreground"))
                            .font(.title2)
                            .fontWeight(.semibold)
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 60))
                            ],
                            spacing: 16
                        ) {
                            ForEach(fullColorChoice == false ? BackgroundColors.sampleMixColors : BackgroundColors.fullMixColors, id: \.hex) { color in
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(hex: color.hex))
                                    .frame(width: 60, height: 60)
                                    .overlay {
                                        if selectedColorHex == color.hex {
                                            Image(systemName: "checkmark")
                                                .font(.title2)
                                                .foregroundStyle(color.name == "Boring White" || color.name == "Beige" || color.name == "Ivory" ? .black : .white)
                                        }
                                    }
                                    .overlay {
                                        if selectedColorHex == color.hex {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    color.name == "Boring White" || color.name == "Beige" || color.name == "Ivory" ? .black : .white,
                                                    lineWidth: 4
                                                )
                                        }
                                    }
                                    .onTapGesture {
                                        selectedColorHex = color.hex
                                    }
                            }
                        }
                        if fullColorChoice == false {
                            Button {
                                fullColorChoice = true
                            } label: {
                                Label("Show More Colors", systemImage: "chevron.down.circle")
                                    .font(.title2)
                            }
                        } else {
                            Button {
                                fullColorChoice = false
                            } label: {
                                Label("Show Less Colors", systemImage: "chevron.up.circle")
                                    .font(.title2)
                            }
                        }
                    }
                    if cTracks.isEmpty {
                        Text("No C-Tracks yet")
                            .foregroundStyle(.secondary)
                    }
                    else {
                        ForEach(cTracks.indices, id: \.self) { index in
                            SwipeView {
                                VStack(alignment: .leading) {
                                    Text(cTracks[index].name ?? "Track \(index + 1)")
                                        .font(.headline)
                                    Text("\(cTracks[index].songIDs.count) songs")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.ultraThinMaterial)
                                .cornerRadius(12)
                            } trailingActions: { swipeContext in
                                SwipeAction("Edit") {
                                    swipeContext.state.wrappedValue = .closed
                                    selectedCTrack = cTracks[index]
                                }
//                                    .allowSwipeToTrigger()
                                SwipeAction("Delete") {
                                    cTracks.remove(at: index)
                                }
                                .swipeActionLabelHorizontalPadding(500)
//                                    .tint(.blue)
                            }
                        }
                    }
                    //button
                    NavigationLink {
                        NewCTrackView(backgroundColorHex: selectedColorHex, cTracks: $cTracks)
                    } label: {
                        Label("Add C-Track", systemImage: "plus.circle.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("C Pop"))
                            .foregroundStyle(Color("C Foreground"))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .cornerRadius(25)
                    }
                }
                Spacer()
                Button("Save C-Mix Changes") {
                    mixVM.updateMix(mix, name: mixName, colorHex: selectedColorHex, cTracks: cTracks, context: context)
                    dismiss()
                }
                .padding()
                .background(Color("C Pop"))
                .foregroundStyle(Color("C Foreground"))
                .font(.title3)
                .fontWeight(.semibold)
                .cornerRadius(25)
            }
            .padding()
        }
        .navigationTitle("Edit C-Mix")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedCTrack) { selectedTrack in
            if let index = cTracks.firstIndex(where: { $0.id == selectedTrack.id }) {
                EditCTrackView(cTrack: $cTracks[index], backgroundColorHex: selectedColorHex, cTracks: $cTracks)
            }
        }
        
//        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    var mix = CMix(name: "Bozo's Good Time Puking Party Mix!!", backgroundColorHex: "#FFFFF0", cTracks: [])
    
    NavigationStack {
        EditCMixView(mix: mix)
    }
}

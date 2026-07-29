//
//  NewCMixView.swift
//  Side C
//
//  Created by Daniel Marsh on 4/23/26.
//

import SwiftUI
import SwiftData
import SwipeActions

struct NewCMixView: View {
    @EnvironmentObject var mixVM: CMixViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    @State private var mixName = ""
    @State private var selectedColorHex = "#89F336"
    @State private var fullColorChoice = false
    @State private var cTracks: [CTrack] = []
    
    var body: some View {
        ZStack {
            ColorToGradient.gradient(from: Color(hex: selectedColorHex))
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 20) {
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
//                                    swipeContext.state.wrappedValue = .closed
//                                    selectedMix = mix
                                    print("Edit")
                                }
//                                    .allowSwipeToTrigger()
                                SwipeAction("Delete") {
//                                    mixVM.deleteMix(mix, context: context)
                                    print("Delete")
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
                Button("Create C-Mix") {
                    mixVM.addMix(name: mixName, colorHex: selectedColorHex, cTracks: cTracks, context: context)
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
        .navigationTitle("New C-Mix")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack{
        NewCMixView()
    }
}

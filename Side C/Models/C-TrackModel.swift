//
//  C-Track Model.swift
//  Side C
//
//  Created by Daniel Marsh on 4/23/26.
//

import Foundation
import SwiftData
import MediaPlayer

@Model
class CTrack: Identifiable {
    var id = UUID()
    var name: String?
    var songIDs: [UInt64]

    init(name: String? = nil, songIDs: [UInt64]) {
        self.name = name
        self.songIDs = songIDs
    }
}

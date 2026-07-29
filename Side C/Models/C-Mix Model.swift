//
//  C-Mix Model.swift
//  Side C
//
//  Created by Daniel Marsh on 4/23/26.
//

import SwiftData

@Model
class CMix {
    var name: String
    var backgroundColorHex: String
    @Relationship(deleteRule: .cascade)
    var cTracks: [CTrack]

    init(name: String, backgroundColorHex: String, cTracks: [CTrack]) {
        self.name = name
        self.backgroundColorHex = backgroundColorHex
        self.cTracks = cTracks
    }
}

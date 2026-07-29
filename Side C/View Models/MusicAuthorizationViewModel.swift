//
//  Untitled.swift
//  Side C
//
//  Created by Daniel Marsh on 4/5/26.
//

import MediaPlayer
import Combine

class MusicAuthorizationViewModel: ObservableObject {
    
    @Published var authorizationStatus: MPMediaLibraryAuthorizationStatus = .notDetermined
    
    func requestMusicAccess() {
        MPMediaLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                self.authorizationStatus = status
            }
        }
    }
}

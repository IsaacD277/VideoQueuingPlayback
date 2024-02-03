//
//  PlayerManager.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 2/2/24.
//

import AVKit
import Foundation

class PlayerManager: ObservableObject {
    @Published var player = AVQueuePlayer()
    
    func addToQueue(_ url: URL) {
        player.insert(AVPlayerItem(url: url), after: nil)
        print("added!!")
    }
    
    func removeFromQueue(_ url: URL) {
        player.remove(AVPlayerItem(url: url))
    }
}

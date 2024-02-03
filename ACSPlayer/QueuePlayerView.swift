//
//  QueuePlayerView.swift
//  ACSPlayer
//
//  Created by Isaac D2 on 1/26/24.
//

import SwiftUI
import AVKit

struct QueuePlayerView: View {
    @ObservedObject var playerManager = PlayerManager()
    var size: CGFloat
    
    init(size: CGFloat = 500, playerManager: PlayerManager) {
        self.size = size
        self.playerManager = playerManager
    }
    
    var body: some View {
        VideoPlayer(player: playerManager.player)
            .frame(width: size, height: size / 16 * 9) // Adjust size as needed
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
    }
}


#Preview {
    QueuePlayerView(playerManager: PlayerManager())
}

// URL(string: "file:///Users/isaacd2/Movies/Reel/TGU Jib Shot 3.mov")!
